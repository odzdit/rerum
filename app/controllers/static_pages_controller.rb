class StaticPagesController < ApplicationController
	
	def dashboard
			 @data = {
              labels: ["January", "February", "March", "April", "May", "June", "July"],
              datasets: [
                {
                    label: "My First dataset",
                    backgroundColor: "rgba(220,220,220,0.2)",
                    borderColor: "rgba(220,220,220,1)",
                    data: [65, 59, 80, 81, 56, 55, 40]
                },
                {
                    label: "My Second dataset",
                    backgroundColor: "rgba(151,187,205,0.2)",
                    borderColor: "rgba(151,187,205,1)",
                    data: [28, 48, 40, 19, 86, 27, 90]
                },
                { 
                    label: "My Third dataset",
                    backgroundColor: "rgba(151,187,205,0.2)",
                    borderColor: "rgba(151,187,205,1)",
                    data: [20, 20, 40, 20, 20, 20, 90]
                }
              ]
            } 
            @options = {:width => 800, :height => 300}             
	end

end
