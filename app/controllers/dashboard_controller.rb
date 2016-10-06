require 'awesome_print'
class DashboardController < ApplicationController
require 'adwords_api'
before_action :authenticate_user!

def dashboard
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
            campaigns_data_array[name]["cost_array"].push campaigns_data_array[name]["#{campaign_data_point['day']}"][:cost] / 100000
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

      ap days_data_array
   @dashboard_kpi = DashboardKpi.new(days_data_array).package
   weekly_graph = Graph.new(@dashboard_kpi[:days], campaigns_data_array)
   @data = weekly_graph.make_graph_clicks
   @options = weekly_graph.options
             
  end

    def weekly_dashboard_impressions
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
                campaigns_data_array[name]["cost_array"].push campaigns_data_array[name]["#{campaign_data_point['day']}"][:cost] / 100000
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
      weekly_graph = Graph.new(@dashboard_kpi[:days], campaigns_data_array)
      @data = weekly_graph.make_graph_impressions
      @options = weekly_graph.options
    end


    def weekly_dashboard_cost
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
                campaigns_data_array[name]["cost_array"].push campaigns_data_array[name]["#{campaign_data_point['day']}"][:cost] / 100000
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
      weekly_graph = Graph.new(@dashboard_kpi[:days], campaigns_data_array)
      @data = weekly_graph.make_graph_cost
      @options = weekly_graph.options
    end


      def weekly_dashboard_conversions
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
                  campaigns_data_array[name]["cost_array"].push campaigns_data_array[name]["#{campaign_data_point['day']}"][:cost] / 100000
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
        weekly_graph = Graph.new(@dashboard_kpi[:days], campaigns_data_array)
        @data = weekly_graph.make_graph_conversions
        @options = weekly_graph.options
      end


def dashboard_test
    @data = {
        labels: ["January", "February", "March", "April", "May", "June", "July"],
        datasets: [
            {
                label: "My First dataset",
                backgroundColor: "rgba(220,220,220,0.2)",
                borderColor: "rgba(220,220,220,1)",
                data: [65, 59, 80, 81, 56, 55, 40]
            },
            {
                label: "My Second dataset",
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


def monthly_report
  
             
end


def yearly_report
   
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
          :date_range => [:min => "20160101", :max => "20160920"]
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