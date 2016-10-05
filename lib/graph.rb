class Graph
  def initialize(dates, graph_package)
    @dates = dates
    @graph_package = graph_package
  end

  def make_graph_cost
    i = -1
    dataset_array = @graph_package.map do |key, value |
              colors = ["rgba(49,115,126,.8)", "rgba(245,185,69,.8)", "rgba(31,160,132,.8)", "rgba(47,186,157,.8)", "rgba(222,124,0,.8)", "rgba(49,136,253,.8)", "rgba(80,158,47,.8)"]
              i += 1
              p colors[i]
              {
                label: key,
                yAxisID: "y-axis-1",
                backgroundColor: "rgba(220,220,220,0.2)",
                borderColor: colors[i],
                data: value["cost_array"]
              }
              end
    
{           
    labels: @dates,            
          datasets: 
                dataset_array
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