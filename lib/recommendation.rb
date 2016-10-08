class Recommendation
attr_accessor :takeaway, :recommendation, :implementation

    def initialize(kpi)
        @kpi = kpi
        end 

        def compare_cpa
            if @kpi > 300
                @kpi_stuff = {
                takeaway: "Your CPA is above 2015's Average'",
                recommendation: "Cut spend on low ROI keywords/Lower visibility on them",
                implementation: "Medium"
                }
            else
                @kpi_stuff = {
                takeaway: "You're CPA is below average 2015 average",
                recommendation: "Search for converting keywords with position that could be improved to push them",
                implementation: "Medium"
                }
            end
            return @kpi_stuff        
        end

        def compare_ctr
            if @kpi > 3.5
                @kpi_stuff = {
                takeaway: "CTR is above this month's average",
                recommendation: "Check for Imp. Share to ensure visibility is close to 100%",
                implementation: "Easy"
                }
            else
                @kpi_stuff = {
                takeaway: "CTR is below this month's average",
                recommendation: "Your Keywords might be too broad. Try checking for broad keyword spend / Perform SQR" ,
                implementation: "Hard"
                }
            end
            return @kpi_stuff        
        end







end 