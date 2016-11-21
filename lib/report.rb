class Report
    def initialize(client_adwords_id)
    @client_adwords_id = client_adwords_id
    end
    
 def download_criteria_report()
      # AdwordsApi::Api will read a config file from ENV['HOME']/adwords_api.yml
      # when called without parameters.
      adwords = AdwordsApi::Api.new
    #   adwords.credential_handler.set_credential(:client_customer_id, current_user.adwords_id)
      adwords.credential_handler.set_credential(:client_customer_id, @client_adwords_id)

      # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
      # the configuration file or provide your own logger:
      # adwords.logger = Logger.new('adwords_xml.log')

      # Get report utilities for the version.
      report_utils = adwords.report_utils(:v201607)

      # Define report definition. You can also pass your own XML text as a string.
      report_definition = {
        :selector => {
          :fields => ['Date','CampaignName', 'Impressions', 'Clicks', 'Cost', 'Conversions'],
             :date_range => {:min => '20161001', :max => '20161115'},
          :predicates => [
              {:field => 'CampaignName', :operator => 'CONTAINS', :values => "_"}
          ]
        },
        :report_name => 'Last 7 days ACCOUNT_PERFORMANCE_REPORT',
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