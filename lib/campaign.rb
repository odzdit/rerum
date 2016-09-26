class Campaign
    def initialize(campaigns)
        @campaigns = campaigns
        end 

        def clean_campaign
            @campaigns.each do |campaign_name|
                campaign_name.sub! 'G|NB_', ''
                campaign_name.sub! '-ES@MX', ''
                campaign_name.sub! 'G|BR_', ''
             end
        end
end 