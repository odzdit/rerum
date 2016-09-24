class Graph
  def initialize(dates, conversions, cost)
    @dates = dates
    @conversions = conversions
    @cost = cost
  end

  def make_graph_data

{
    labels: @dates,
          datasets: [
            {
                label: "Conversions",
                yAxisID: "y-axis-1",
                backgroundColor: "rgba(220,220,220,0.2)",
                borderColor: "rgba(49,136,253,.8)",
                data: @conversions
            },
            { 
                label: "Cost",
                yAxisID: "y-axis-2",
                backgroundColor: "rgba(151,187,205,0.2)",
                borderColor: "rgba(151,187,205,1)",
                data: @cost
            }
          ]
        } 
       
  end

  def options
         {
          :width => 1000,
         :height => 300,
         :scales => {
              :yAxes => [
                {:type => "linear", :id => "y-axis-1", :display => true, :position => "right"},
                {:type => "linear", :id => "y-axis-2", :display => true, :position => "left"}
           ]
         }
       } 
  end
end