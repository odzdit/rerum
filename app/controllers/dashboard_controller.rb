class DashboardController < ApplicationController

def dashboard
        @adwords_data = download_criteria_report()
            data_hash = Hash.from_xml(@adwords_data)
            print JSON.pretty_generate(JSON.parse(data_hash.to_json))

			 @data = {
              labels: ["January", "February", "March", "April", "May", "June", "July"],
              datasets: [
                {
                    label: "Impressions",
                    backgroundColor: "rgba(220,220,220,0.2)",
                    borderColor: "rgba(220,220,220,1)",
                    data: [65, 59, 80, 81, 56, 55, 40]
                },
                {
                    label: "Clicks",
                    backgroundColor: "rgba(151,187,205,0.2)",
                    borderColor: "rgba(151,187,205,1)",
                    data: [28, 48, 40, 19, 86, 27, 90]
                },
                { 
                    label: "Cost",
                    backgroundColor: "rgba(151,187,205,0.2)",
                    borderColor: "rgba(151,187,205,1)",
                    data: [20, 20, 40, 20, 20, 20, 90]
                }
              ]
            } 
            @options = {:width => 1000, :height => 300}             
	end

private

    def download_criteria_report()
      # AdwordsApi::Api will read a config file from ENV['HOME']/adwords_api.yml
      # when called without parameters.
      adwords = AdwordsApi::Api.new

      # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
      # the configuration file or provide your own logger:
      # adwords.logger = Logger.new('adwords_xml.log')

      # Get report utilities for the version.
      report_utils = adwords.report_utils(:v201607)

      # Define report definition. You can also pass your own XML text as a string.
      report_definition = {
        :selector => {
          :fields => ['AdGroupName', 'AdGroupId', 'Impressions', 'Clicks', 'Cost', 'AverageCpc', 'AveragePosition', 'Date'],
        },
        :report_name => 'Last 7 days ADGROUP_PERFORMANCE_REPORT',
        :report_type => 'ADGROUP_PERFORMANCE_REPORT',
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
      API_VERSION = :v201607

      begin
        # File name to write report to.
        file_name = 'Adgroup Report'
        download_criteria_report(file_name)

      # Authorization error.
      rescue AdsCommon::Errors::OAuth2VerificationRequired => e
        puts "Authorization credentials are not valid. Edit adwords_api.yml for " +
            "OAuth2 client ID and secret and run misc/setup_oauth2.rb example " +
            "to retrieve and store OAuth2 tokens."
        puts "See this wiki page for more details:\n\n  " +
            'https://github.com/googleads/google-api-ads-ruby/wiki/OAuth2'

      # HTTP errors.
      rescue AdsCommon::Errors::HttpError => e
        puts "HTTP Error: %s" % e

      # API errors.
      rescue AdwordsApi::Errors::ReportError => e
        puts "Reporting Error: %s" % e.message
      end

    end
end
