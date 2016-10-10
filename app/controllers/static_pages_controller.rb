class StaticPagesController < ApplicationController

    def home
        @data = {
        labels: ["January", "February", "March", "April", "May", "June", "July"],
        datasets: [
            {
                label: "Shirts",
                backgroundColor: "rgba(220,220,220,0.2)",
                borderColor: "rgba(232,111,12,1)",
                data: [28, 20, 70, 60, 86, 27, 90]
            },
            {
                label: "Shoes",
                backgroundColor: "rgba(151,187,205,0.2)",
                borderColor: "rgba(12,151,232,1)",
                data: [10, 20, 30, 35, 35, 27, 90]
            },
             {
                label: "Hats",
                backgroundColor: "rgba(220,220,220,0.2)",
                borderColor: "rgba(232,12,96,1)",
                data: [80, 48, 30, 25, 75, 30, 20]

             },
              {
                label: "Sunglasses",
                backgroundColor: "rgba(220,220,220,0.2)",
                borderColor: "rgba(232,184,12,1)",
                data: [30, 50, 42, 55, 60, 69, 100]
              }
            
        ]
        }
        @options = {
          :width => 1000,
         :height => 500,
         :scales => {
              :yAxes => [
                {:type => "linear", :id => "y-axis-1", :display => true, :position => "right"},
                {:type => "linear", :id => "y-axis-2", :display => true, :position => "left"}
           ]
         }
       } 
    end
	
    def about_us
    end

end
