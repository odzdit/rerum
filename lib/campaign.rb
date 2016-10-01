class Campaign
    def initialize(campaign)
        @campaign = campaign
        end 

        def clean_campaign
                @campaign = @campaign.sub 'G|BR_', ''
                @campaign = @campaign = @campaign.sub 'G|NB_', ''
                @campaign = @campaign.sub '-ES@MX', ''
        end
end 