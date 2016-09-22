class DashboardController < ApplicationController
require 'adwords_api'
before_action :authenticate_user!


def dashboard
        @adwords_id = current_user.adwords_id
        p @adwords_id
        @adwords_data = download_criteria_report()
            data_hash = Hash.from_xml(@adwords_data)
            data_json = JSON.parse(data_hash.to_json)["report"]["table"]["row"]

	            impressions = []
				clicks = []
				cost = []
				dates = []

				data_json.sort_by! do |item|
					item["day"]
				end

				data_json.each do |object|
					# object["impressions"]
				    impressions.push(object["impressions"])
				    clicks.push(object["clicks"])
				    cost.push(object["cost"])
				    dates.push(object["day"])
				  end
				  
				  cost2 = cost.map do |cost|
					new_cost = cost.to_i
					decimal_cost = new_cost/1000000
					p decimal_cost.to_f
				end


			 @data = {
			  labels: dates,
              datasets: [
                {
                    label: "Impressions",
                    backgroundColor: "rgba(220,220,220,0.2)",
                    borderColor: "rgba(49,136,253,.8)",
                    data: impressions
                },
                { 
                    label: "Cost",
                    backgroundColor: "rgba(151,187,205,0.2)",
                    borderColor: "rgba(151,187,205,1)",
                    data: cost2
                }
              ]
            } 
            @options = {:width => 1000, :height => 300}             
	end

private

    def download_criteria_report()
      # AdwordsApi::Api will read a config file from ENV['HOME']/adwords_api.yml
      # when called without parameters.
      # adwords = AdwordsApi::Api.new
          adwords = AdwordsApi::Api.new({
          :authentication => {
            :method => 'OAuth2',
            :oauth2_client_id => ENV['adwords_oauth2_client_id'],
            :oauth2_client_secret => ENV['adwords_oauth2_client_secret'],
            :developer_token => ENV['adwords_developer_token'],
            :client_customer_id => "451-846-4440",
            :user_agent => 'rerum',
            :oauth_2token => {
               :access_token => ENV['adwords_oauth2_access_token'],
               :refresh_token => "ya29.Ci9XA6O_v94Nb6KYuEmkfgCmtR57CX3_QZ4k-Ulqa0memKiUS8qfRwIU1aY-49fhzA"
            }
          },
          :service => {
            :environment => 'PRODUCTION'
          }
        })
  
  
      # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
      # the configuration file or provide your own logger:
      # adwords.logger = Logger.new('adwords_xml.log')

      # Get report utilities for the version.
      report_utils = adwords.report_utils(:v201607)

      # Define report definition. You can also pass your own XML text as a string.
      report_definition = {
        :selector => {
          :fields => ['Impressions', 'Clicks', 'Cost', 'AverageCpc', 'AveragePosition', 'Date'],
        },
        :report_name => 'Last 14 days ACCOUNT_PERFORMANCE_REPORT',
        :report_type => 'ACCOUNT_PERFORMANCE_REPORT',
        :download_format => 'XML',
        :date_range_type => 'LAST_14_DAYS',
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
