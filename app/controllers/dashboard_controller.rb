class DashboardController < ApplicationController
require 'adwords_api'
before_action :authenticate_user!

  def dashboard
    @adwords_data = Report.new(current_user.adwords_id).download_criteria_report
    dashboard_report = DashboardHandler.new(@adwords_data)  
    campaigns_data_array =  dashboard_report.parse_report
    days_data_array = dashboard_report.parse_report_days
    
    @dashboard_kpi = DashboardKpi.new(days_data_array).package
    @cpa_recommendation = Recommendation.new(@dashboard_kpi[:cpa]).compare_cpa
    @ctr_recommendation = Recommendation.new(@dashboard_kpi[:cpa]).compare_ctr

    weekly_graph = Graph.new(@dashboard_kpi[:days], campaigns_data_array)
    @data = weekly_graph.make_graph_clicks
    @options = weekly_graph.options      
  end

  def weekly_dashboard_impressions
    @adwords_data = Report.new(current_user.adwords_id).download_criteria_report
    dashboard_report = DashboardHandler.new(@adwords_data)  
    campaigns_data_array =  dashboard_report.parse_report
    days_data_array = dashboard_report.parse_report_days

    @dashboard_kpi = DashboardKpi.new(days_data_array).package
    @cpa_recommendation = Recommendation.new(@dashboard_kpi[:cpa]).compare_cpa
    @ctr_recommendation = Recommendation.new(@dashboard_kpi[:cpa]).compare_ctr

    weekly_graph = Graph.new(@dashboard_kpi[:days], campaigns_data_array)
    @data = weekly_graph.make_graph_impressions
    @options = weekly_graph.options
  end


  def weekly_dashboard_cost
    @adwords_data = Report.new(current_user.adwords_id).download_criteria_report
    dashboard_report = DashboardHandler.new(@adwords_data)  
    campaigns_data_array =  dashboard_report.parse_report
    days_data_array = dashboard_report.parse_report_days

      
    @dashboard_kpi = DashboardKpi.new(days_data_array).package
    @cpa_recommendation = Recommendation.new(@dashboard_kpi[:cpa]).compare_cpa
    @ctr_recommendation = Recommendation.new(@dashboard_kpi[:cpa]).compare_ctr

    weekly_graph = Graph.new(@dashboard_kpi[:days], campaigns_data_array)
    @data = weekly_graph.make_graph_cost
    @options = weekly_graph.options
  end


  def weekly_dashboard_conversions
    @adwords_data = Report.new(current_user.adwords_id).download_criteria_report
    dashboard_report = DashboardHandler.new(@adwords_data)  
    campaigns_data_array =  dashboard_report.parse_report
    days_data_array = dashboard_report.parse_report_days
       
    @dashboard_kpi = DashboardKpi.new(days_data_array).package
    @cpa_recommendation = Recommendation.new(@dashboard_kpi[:cpa]).compare_cpa
    @ctr_recommendation = Recommendation.new(@dashboard_kpi[:cpa]).compare_ctr

    weekly_graph = Graph.new(@dashboard_kpi[:days], campaigns_data_array)
    @data = weekly_graph.make_graph_conversions
    @options = weekly_graph.options
  end

  def weekly_dashboard_ctr
    @adwords_data = Report.new(current_user.adwords_id).download_criteria_report
    dashboard_report = DashboardHandler.new(@adwords_data)  
    campaigns_data_array =  dashboard_report.parse_report
    days_data_array = dashboard_report.parse_report_days

    @dashboard_kpi = DashboardKpi.new(days_data_array).package
    @cpa_recommendation = Recommendation.new(@dashboard_kpi[:cpa]).compare_cpa
    @ctr_recommendation = Recommendation.new(@dashboard_kpi[:cpa]).compare_ctr

    weekly_graph = Graph.new(@dashboard_kpi[:days], campaigns_data_array)
    @data = weekly_graph.make_graph_ctr
    @options = weekly_graph.options           
  end


  def weekly_dashboard_conversion_rate
    @adwords_data = Report.new(current_user.adwords_id).download_criteria_report
    dashboard_report = DashboardHandler.new(@adwords_data)  
    campaigns_data_array =  dashboard_report.parse_report
    days_data_array = dashboard_report.parse_report_days
    
    @dashboard_kpi = DashboardKpi.new(days_data_array).package
    @cpa_recommendation = Recommendation.new(@dashboard_kpi[:cpa]).compare_cpa
    @ctr_recommendation = Recommendation.new(@dashboard_kpi[:cpa]).compare_ctr

    weekly_graph = Graph.new(@dashboard_kpi[:days], campaigns_data_array)
    @data = weekly_graph.make_graph_conv_rate
    @options = weekly_graph.options
  end

  def weekly_dashboard_cpa
      @adwords_data = Report.new(current_user.adwords_id).download_criteria_report
    dashboard_report = DashboardHandler.new(@adwords_data)  
    campaigns_data_array =  dashboard_report.parse_report
    days_data_array = dashboard_report.parse_report_days

  
   @dashboard_kpi = DashboardKpi.new(days_data_array).package
   @cpa_recommendation = Recommendation.new(@dashboard_kpi[:cpa]).compare_cpa
   @ctr_recommendation = Recommendation.new(@dashboard_kpi[:cpa]).compare_ctr

   weekly_graph = Graph.new(@dashboard_kpi[:days], campaigns_data_array)
   @data = weekly_graph.make_graph_cpa
   @options = weekly_graph.options

             
  end

  def weekly_dashboard_cpc
    @adwords_data = Report.new(current_user.adwords_id).download_criteria_report
    dashboard_report = DashboardHandler.new(@adwords_data)  
    campaigns_data_array =  dashboard_report.parse_report
    days_data_array = dashboard_report.parse_report_days

    @dashboard_kpi = DashboardKpi.new(days_data_array).package
    @cpa_recommendation = Recommendation.new(@dashboard_kpi[:cpa]).compare_cpa
    @ctr_recommendation = Recommendation.new(@dashboard_kpi[:cpa]).compare_ctr

    weekly_graph = Graph.new(@dashboard_kpi[:days], campaigns_data_array)
    @data = weekly_graph.make_graph_cpc
    @options = weekly_graph.options        
  end

def dashboard_test
    @data = {
        labels: ["January", "February", "March", "April", "May", "June", "July"],
        datasets: [
            {
                label: "Shoes",
                backgroundColor: "rgba(220,220,220,0.2)",
                borderColor: "rgba(220,220,220,1)",
                data: [65, 59, 80, 81, 56, 55, 40]
            },
            {
                label: "Shirtst",
                backgroundColor: "rgba(151,187,205,0.2)",
                borderColor: "rgba(151,187,205,1)",
                data: [28, 48, 40, 19, 86, 27, 90]
            }
        ]
        }
        @options = {
          :width => 1000,
         :height => 300,
         :scales => {
              :yAxes => [
                {:type => "linear", :id => "y-axis-1", :display => true, :position => "right"},
                {:type => "linear", :id => "y-axis-2", :display => true, :position => "left"}
           ]
         }
       } 
    

end


def dashboard_geographic
@adwords_data = download_criteria_report()
        data_hash = Hash.from_xml(@adwords_data)
        data_json = JSON.parse(data_hash.to_json)["report"]["table"]["row"]
      
      data_json.sort_by! do |item|
        item["day"]
      end

      campaigns = data_json.group_by{ 
        |object| Campaign.new(object['campaign']).clean_campaign
      }
            # ap campaigns
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
              p campaigns_data_array[name]["cpc_array"].push 0 
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
              campaigns_data_array[name]["ctr_array"].push ((campaigns_data_array[name]["#{campaign_data_point['day']}"][:clicks] / campaigns_data_array[name]["#{campaign_data_point['day']}"][:impressions]) * 100) 
            end
          end
        end
             


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
    @dashboard_kpi = DashboardKpi.new(days_data_array).package
   @cpa_recommendation = Recommendation.new(@dashboard_kpi[:cpa]).compare_cpa
   @ctr_recommendation = Recommendation.new(@dashboard_kpi[:cpa]).compare_ctr

   weekly_graph = Graph.new(@dashboard_kpi[:days], campaigns_data_array)

    @data = {
        labels: ["Mexico City", "Estate of Mexico", "Monterrey"],
        datasets: [
            {
                data: [7,3,1],
                backgroundColor: ["#FF6384", "#36A2EB", "#FFCE56"],

            }
        ]
        }
        @options = {
          :width => 1000,
         :height => 300
         }
       
end

def monthly_report
      @adwords_data = download_monthly_report()
        data_hash = Hash.from_xml(@adwords_data)
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

   @dashboard_kpi = DashboardKpi.new(days_data_array).package
   @cpa_recommendation = Recommendation.new(@dashboard_kpi[:cpa]).compare_cpa
   @ctr_recommendation = Recommendation.new(@dashboard_kpi[:cpa]).compare_ctr

   weekly_graph = Graph.new(@dashboard_kpi[:days], campaigns_data_array)
   @data = weekly_graph.make_graph_clicks
   @options = weekly_graph.options  
             
end


def yearly_report
    @adwords_data = download_yearly_report()
        data_hash = Hash.from_xml(@adwords_data)
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

   @dashboard_kpi = DashboardKpi.new(days_data_array).package
   @cpa_recommendation = Recommendation.new(@dashboard_kpi[:cpa]).compare_cpa
   @ctr_recommendation = Recommendation.new(@dashboard_kpi[:cpa]).compare_ctr

   weekly_graph = Graph.new(@dashboard_kpi[:days], campaigns_data_array)
   @data = weekly_graph.make_graph_clicks
   @options = weekly_graph.options  
end


private

    def download_criteria_report()
      # AdwordsApi::Api will read a config file from ENV['HOME']/adwords_api.yml
      # when called without parameters.
      adwords = AdwordsApi::Api.new
      adwords.credential_handler.set_credential(:client_customer_id, current_user.adwords_id)
         
  
  
      # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
      # the configuration file or provide your own logger:
      # adwords.logger = Logger.new('adwords_xml.log')

      # Get report utilities for the version.
      report_utils = adwords.report_utils(:v201607)

      # Define report definition. You can also pass your own XML text as a string.
      report_definition = {
        :selector => {
          :fields => ['Date','CampaignName', 'Impressions', 'Clicks', 'Cost', 'Conversions'],
          :predicates => [
              {:field => 'CampaignName', :operator => 'CONTAINS', :values => "_"}
          ]
        },
        :report_name => 'Last 7 days ACCOUNT_PERFORMANCE_REPORT',
        :report_type => 'CAMPAIGN_PERFORMANCE_REPORT',
        :download_format => 'XML',
        :date_range_type => 'LAST_7_DAYS',
      }

      # Optional: Set the configuration of the API instance to suppress header,
      # column name, or summary rows in the report output. You can also configure
      # this in your adwords_api.yml configuration file.
      adwords.skip_report_header = true
      adwords.skip_column_header = false
      adwords.skip_report_summary = true
      # Enable to allow rows with zero impressions to show.
      adwords.include_zero_impressions = false

      # Download report, using "download_report_as_file" utility method.
      # To retrieve the report as return value, use "download_report" method.
      return report_utils.download_report(report_definition)
    end

    if __FILE__ == $0
      A

    end


        def download_monthly_report()
      # AdwordsApi::Api will read a config file from ENV['HOME']/adwords_api.yml
      # when called without parameters.
      adwords = AdwordsApi::Api.new
      adwords.credential_handler.set_credential(:client_customer_id, current_user.adwords_id)
         
  
  
      # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
      # the configuration file or provide your own logger:
      # adwords.logger = Logger.new('adwords_xml.log')

      # Get report utilities for the version.
      report_utils = adwords.report_utils(:v201607)

      # Define report definition. You can also pass your own XML text as a string.
      report_definition = {
        :selector => {
          :fields => ['Date','CampaignName', 'Impressions', 'Clicks', 'Cost', 'Conversions'],
          :predicates => [
              {:field => 'CampaignName', :operator => 'CONTAINS', :values => "_"}
          ]
        },
        :report_name => 'THIS MONTH CAMPAIGN_PERFORMANCE_REPORT',
        :report_type => 'CAMPAIGN_PERFORMANCE_REPORT',
        :download_format => 'XML',
        :date_range_type => 'THIS_MONTH',
      }

      # Optional: Set the configuration of the API instance to suppress header,
      # column name, or summary rows in the report output. You can also configure
      # this in your adwords_api.yml configuration file.
      adwords.skip_report_header = true
      adwords.skip_column_header = false
      adwords.skip_report_summary = true
      # Enable to allow rows with zero impressions to show.
      adwords.include_zero_impressions = false

      # Download report, using "download_report_as_file" utility method.
      # To retrieve the report as return value, use "download_report" method.
      return report_utils.download_report(report_definition)
    end

    if __FILE__ == $0
      A

    end

       def download_yearly_report()
      # AdwordsApi::Api will read a config file from ENV['HOME']/adwords_api.yml
      # when called without parameters.
      adwords = AdwordsApi::Api.new
      adwords.credential_handler.set_credential(:client_customer_id, current_user.adwords_id)
         
  
  
      # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
      # the configuration file or provide your own logger:
      # adwords.logger = Logger.new('adwords_xml.log')

      # Get report utilities for the version.
      report_utils = adwords.report_utils(:v201607)

      # Define report definition. You can also pass your own XML text as a string.
      report_definition = {
        :selector => {
          :fields => ['Date','CampaignName', 'Impressions', 'Clicks', 'Cost', 'Conversions'],
          :predicates => [
              {:field => 'CampaignName', :operator => 'CONTAINS', :values => "_"}
          ],
          :date_range => [:min => "20160101", :max => "20161020"]
        },
        :report_name => 'yearly CAMPAIGN_PERFORMANCE_REPORT',
        :report_type => 'CAMPAIGN_PERFORMANCE_REPORT',
        :download_format => 'XML',
        :date_range_type => 'CUSTOM_DATE',
      }

      # Optional: Set the configuration of the API instance to suppress header,
      # column name, or summary rows in the report output. You can also configure
      # this in your adwords_api.yml configuration file.
      adwords.skip_report_header = true
      adwords.skip_column_header = false
      adwords.skip_report_summary = true
      # Enable to allow rows with zero impressions to show.
      adwords.include_zero_impressions = false

      # Download report, using "download_report_as_file" utility method.
      # To retrieve the report as return value, use "download_report" method.
      return report_utils.download_report(report_definition)
    end

    if __FILE__ == $0
      A

    end

















end