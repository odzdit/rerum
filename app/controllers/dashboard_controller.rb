class DashboardController < ApplicationController
require 'adwords_api'

before_action :authenticate_user!


def dashboard
    @adwords_data = download_criteria_report()
        data_hash = Hash.from_xml(@adwords_data)
        data_json = JSON.parse(data_hash.to_json)["report"]["table"]["row"]
        
    campaigns = []
    dates = []
    impressions = []
		clicks = []
		cost = []
    conversions = []

		data_json.sort_by! do |item|
			item["day"]
		end

		data_json.each do |object|
			# object["impressions"]
        conversions.push(object["conversions"])
		    impressions.push(object["impressions"])
		    clicks.push(object["clicks"])
		    cost.push(object["cost"])
		    dates.push(object["day"])
        campaigns.push(object["campaign"])
		  end

      @campaigns = Campaign.new(campaigns).clean_campaign
      p @campaigns
      

    @impressions = DashboardKpi.new(impressions).reduce_array
    @clicks = DashboardKpi.new(clicks).reduce_array
    @cost = DashboardKpi.new(cost).reduce_array/100000
    @conversions = DashboardKpi.new(conversions).reduce_array
    @ctr = ((@clicks.to_f)/(@impressions.to_f)).round(4) * 100
    @cpc = @cost/@clicks
    @cpa = @cost/@conversions rescue 0
    @conv_rate = @clicks/@conversions rescue 0
    
		  cost2 = cost.map do |cost|
			new_cost = cost.to_i
			decimal_cost = new_cost/1000000
		end

   weekly_graph = Graph.new(dates,conversions, cost2)
   @data = weekly_graph.make_graph_data
   @options = weekly_graph.options
             
  end


def monthly_report
    @adwords_data = download_monthly_report()
        data_hash = Hash.from_xml(@adwords_data)
        data_json = JSON.parse(data_hash.to_json)["report"]["table"]["row"]
    
    dates = []
    impressions = []
		clicks = []
		cost = []
    conversions = []

		data_json.sort_by! do |item|
			item["day"]
		end

		data_json.each do |object|
			# object["impressions"]
        conversions.push(object["conversions"])
		    impressions.push(object["impressions"])
		    clicks.push(object["clicks"])
		    cost.push(object["cost"])
		    dates.push(object["day"])
		  end

    @impressions = DashboardKpi.new(impressions).reduce_array
    @clicks = DashboardKpi.new(clicks).reduce_array
    @cost = DashboardKpi.new(cost).reduce_array/100000
    @conversions = DashboardKpi.new(conversions).reduce_array
    @ctr = ((@clicks.to_f)/(@impressions.to_f)).round(4) * 100
    @cpc = @cost/@clicks
    @cpa = @cost/@conversions rescue 0
    @conv_rate = @clicks/@conversions rescue 0
    
		  cost2 = cost.map do |cost|
			new_cost = cost.to_i
			decimal_cost = new_cost/1000000
		end

   weekly_graph = Graph.new(dates,conversions, cost2)
   @data = weekly_graph.make_graph_data
   @options = weekly_graph.options
             
  end


def yearly_report
    @adwords_data = download_yearly_report()
        data_hash = Hash.from_xml(@adwords_data)
        data_json = JSON.parse(data_hash.to_json)["report"]["table"]["row"]
    
    dates = []
    impressions = []
		clicks = []
		cost = []
    conversions = []

		data_json.sort_by! do |item|
			item["day"]
		end

		data_json.each do |object|
			# object["impressions"]
        conversions.push(object["conversions"])
		    impressions.push(object["impressions"])
		    clicks.push(object["clicks"])
		    cost.push(object["cost"])
		    dates.push(object["day"])
		  end

    @impressions = DashboardKpi.new(impressions).reduce_array
    @clicks = DashboardKpi.new(clicks).reduce_array
    @cost = DashboardKpi.new(cost).reduce_array/100000
    @conversions = DashboardKpi.new(conversions).reduce_array
    @ctr = ((@clicks.to_f)/(@impressions.to_f)).round(4) * 100
    @cpc = @cost/@clicks
    @cpa = @cost/@conversions rescue 0
    @conv_rate = @clicks/@conversions rescue 0
    
		  cost2 = cost.map do |cost|
			new_cost = cost.to_i
			decimal_cost = new_cost/1000000
		end

   weekly_graph = Graph.new(dates,conversions, cost2)
   @data = weekly_graph.make_graph_data
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