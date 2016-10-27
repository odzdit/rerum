class DashboardHandler
    def initialize(data)
    @data = data
    end

    def parse_report
    data_hash = Hash.from_xml(@data)
    data_json = JSON.parse(data_hash.to_json)["report"]["table"]["row"]
      
      data_json.sort_by! do |item|
			item["day"]
		end

      campaigns = data_json.group_by{ 
        |object| Campaign.new(object['campaign']).clean_campaign
      }

      campaigns_data_array = {}
      
      campaigns.each_with_index do |campaign, index|
      name = campaign[0]
      campaigns_data_array[name] = {}
        campaigns_data_array[name]["clicks_array"] = []         
        campaigns_data_array[name]["cost_array"] = []         
        campaigns_data_array[name]["conversions_array"] = []         
        campaigns_data_array[name]["impressions_array"] = []
        campaigns_data_array[name]["cpc_array"] = []
        campaigns_data_array[name]["conversion_rate_array"] = []
        campaigns_data_array[name]["cpa_array"] = []
        campaigns_data_array[name]["ctr_array"] = []
        
        campaign[1].each do |campaign_data_point|

              campaigns_data_array[name]["#{campaign_data_point['day']}"] = {
                clicks: campaign_data_point['clicks'].to_i,
                impressions: campaign_data_point['impressions'].to_i,
                cost: campaign_data_point['cost'].to_i,
                conversions: campaign_data_point['conversions'].to_i,
              }  
            
            campaigns_data_array[name]["impressions_array"].push campaigns_data_array[name]["#{campaign_data_point['day']}"][:impressions]
            campaigns_data_array[name]["conversions_array"].push campaigns_data_array[name]["#{campaign_data_point['day']}"][:conversions]
            campaigns_data_array[name]["clicks_array"].push campaigns_data_array[name]["#{campaign_data_point['day']}"][:clicks]
            campaigns_data_array[name]["cost_array"].push campaigns_data_array[name]["#{campaign_data_point['day']}"][:cost] / 1000000
            
            # manual operations
             if ((campaigns_data_array[name]["#{campaign_data_point['day']}"][:cost] / campaigns_data_array[name]["#{campaign_data_point['day']}"][:clicks]) rescue 0) == 0 
              campaigns_data_array[name]["cpc_array"].push 0 
            else
              campaigns_data_array[name]["cpc_array"].push ((campaigns_data_array[name]["#{campaign_data_point['day']}"][:cost] / campaigns_data_array[name]["#{campaign_data_point['day']}"][:clicks])) / 1000000 rescue 0
            end

             if campaigns_data_array[name]["#{campaign_data_point['day']}"][:conversions] == 0
              campaigns_data_array[name]["conversion_rate_array"].push 0
             else
              campaigns_data_array[name]["conversion_rate_array"].push campaigns_data_array[name]["#{campaign_data_point['day']}"][:conversions].to_f / campaigns_data_array[name]["#{campaign_data_point['day']}"][:clicks].to_f rescue 0
            end
          
           if ((campaigns_data_array[name]["#{campaign_data_point['day']}"][:cost] / campaigns_data_array[name]["#{campaign_data_point['day']}"][:conversions]) rescue 0) == 0 
              campaigns_data_array[name]["cpa_array"].push 0 
            else
              campaigns_data_array[name]["cpa_array"].push ((campaigns_data_array[name]["#{campaign_data_point['day']}"][:cost] / campaigns_data_array[name]["#{campaign_data_point['day']}"][:clicks])) / 1000000 rescue 0
            end
              
              if ((campaigns_data_array[name]["#{campaign_data_point['day']}"][:clicks] / campaigns_data_array[name]["#{campaign_data_point['day']}"][:impressions]) rescue 0) == 0 
              campaigns_data_array[name]["ctr_array"].push 0 
            else
              campaigns_data_array[name]["ctr_array"].push campaigns_data_array[name]["#{campaign_data_point['day']}"][:clicks] / campaigns_data_array[name]["#{campaign_data_point['day']}"][:impressions] rescue 0
            end
          end
        end
        return campaigns_data_array
    end
    

    def parse_report_days
    data_hash = Hash.from_xml(@data)
    data_json = JSON.parse(data_hash.to_json)["report"]["table"]["row"]

    days = data_json.group_by{ |object| object['day'] }
      days_data_array = {}

      days.each do |day|
        days_data_array[day[0]] = {
          clicks: 0,
          impressions: 0,
          cost: 0,
          conversions:0
        }
        day[1].each do |day_data_point|
          days_data_array[day[0]] = {
            clicks: days_data_array[day[0]][:clicks] + day_data_point['clicks'].to_i,
            impressions: days_data_array[day[0]][:impressions] + day_data_point['impressions'].to_i,
            cost: days_data_array[day[0]][:cost] + day_data_point['cost'].to_i,
            conversions:days_data_array[day[0]][:conversions] + day_data_point['conversions'].to_i,          
          }
        end
      end
    return days_data_array
    end
end