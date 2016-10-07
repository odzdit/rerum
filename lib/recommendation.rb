class Recommendation
attr_accessor :takeaway, :recommendation, :implementation

    def initialize(kpi)
        @kpi = kpi
        end 

        def compare_cost
        if @kpi > 1000
         @takeaway = "Cost is high"
         @recommendation = "Decrease CPC"
         @implementation = "Easy"
        end
        return @result
    end
end 