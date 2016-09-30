class Campaign
    def initialize(campaign)
        @campaign = campaign
        end 

        def clean_campaign
                @campaign.sub! 'G|BR_', ''
                @campaign.sub! 'G|NB_', ''
                @campaign.sub! '-ES@MX', ''
        end
end 