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


      campaigns = data_json.group_by{ |object| object['campaign'] }
      campaigns_data_array = {}

      campaigns.each_with_index do |campaign, index|
        name = campaign[0]
        campaigns_data_array[name] = {}

        campaign[1].each do | campaign_data_point |
            # puts campaigns_data_array[name]
            # puts "#{campaign_data_point['day']}"

              campaigns_data_array[name]["#{campaign_data_point['day']}"] = {
                clicks: campaign_data_point['clicks'].to_i,
                impressions: campaign_data_point['impressions'].to_i,
                cost: campaign_data_point['cost'].to_i,
                conversions: campaign_data_point['conversions'].to_i
              } 
          end
        end

        ap campaigns_data_array


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
            conversions:days_data_array[day[0]][:conversions] + day_data_point['conversions'].to_i
          }
        end
      end

    campaigns = []
    dates = []
    impressions = []
		clicks = []
		cost = []
    conversions = []

  
  #  @campaigns = Campaign.new(campaigns).clean_campaign
      
   @dashboard_kpi = DashboardKpi.new(days_data_array).package
  #  print @dashboard_kpi

   weekly_graph = Graph.new(@dashboard_kpi[:days], @dashboard_kpi[:conversions_array], @dashboard_kpi[:cost_array])
   @data = weekly_graph.make_graph_data
   @options = weekly_graph.options

   
             
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