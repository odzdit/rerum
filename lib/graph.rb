class Graph
  def initialize(dates, graph_package)
    @dates = dates
    @graph_package = graph_package
  end

      def make_graph_clicks
        i = -1
        dataset_array = @graph_package.map do |key, value |
                  colors = ["rgba(232,111,12,1)", "rgba(12,151,232,1)", "rgba(232,12,96,1)", "rgba(232,184,12,1)", "rgba(222,124,0,.8)", "rgba(0,0,0,.8)", "rgba(80,158,47,.8)"]
                  i += 1
                  {
                    label: key,
                    yAxisID: "y-axis-2",
                    backgroundColor: "rgba(220,220,220,0.2)",
                    borderColor: colors[i],
                    data: value["clicks_array"]
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
                    # {:type => "linear", :id => "y-axis-1", :display => true, :position => "right"},
                    {:type => "linear", :id => "y-axis-2", :display => true, :position => "left"}
              ]
            }
          } 
      end

      def make_graph_impressions
    i = -1
    dataset_array = @graph_package.map do |key, value |
              colors = ["rgba(232,111,12,1)", "rgba(12,151,232,1)", "rgba(232,12,96,1)", "rgba(232,184,12,1)", "rgba(222,124,0,.8)", "rgba(0,0,0,.8)", "rgba(80,158,47,.8)"]
              i += 1
              {
                label: key,
                yAxisID: "y-axis-2",
                backgroundColor: "rgba(220,220,220,0.2)",
                borderColor: colors[i],
                data: value["impressions_array"]
              }
              end
    
{           
    labels: @dates,            
          datasets: 
                dataset_array
              }
  end


  def make_graph_cost
    i = -1
    dataset_array = @graph_package.map do |key, value |
              colors = ["rgba(232,111,12,1)", "rgba(12,151,232,1)", "rgba(232,12,96,1)", "rgba(232,184,12,1)", "rgba(222,124,0,.8)", "rgba(0,0,0,.8)", "rgba(80,158,47,.8)"]
              i += 1
              {
                label: key,
                yAxisID: "y-axis-2",
                backgroundColor: "rgba(220,220,220,0.2)",
                borderColor: colors[i],
                data: value["impressions_array"]
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
                # {:type => "linear", :id => "y-axis-1", :display => true, :position => "right"},
                {:type => "linear", :id => "y-axis-2", :display => true, :position => "left"}
           ]
         }
       } 
  end

    def make_graph_conversions
    i = -1
    dataset_array = @graph_package.map do |key, value |
              colors = ["rgba(232,111,12,1)", "rgba(12,151,232,1)", "rgba(232,12,96,1)", "rgba(232,184,12,1)", "rgba(222,124,0,.8)", "rgba(0,0,0,.8)", "rgba(80,158,47,.8)"]
              i += 1
              {
                label: key,
                yAxisID: "y-axis-2",
                backgroundColor: "rgba(220,220,220,0.2)",
                borderColor: colors[i],
                data: value["conversions_array"]
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
                # {:type => "linear", :id => "y-axis-1", :display => true, :position => "right"},
                {:type => "linear", :id => "y-axis-2", :display => true, :position => "left"}
           ]
         }
       } 
  end

  def make_graph_ctr
        i = -1
        dataset_array = @graph_package.map do |key, value |
                  colors = ["rgba(232,111,12,1)", "rgba(12,151,232,1)", "rgba(232,12,96,1)", "rgba(232,184,12,1)", "rgba(222,124,0,.8)", "rgba(0,0,0,.8)", "rgba(80,158,47,.8)"]
                  i += 1
                  {
                    label: key,
                    yAxisID: "y-axis-2",
                    backgroundColor: "rgba(220,220,220,0.2)",
                    borderColor: colors[i],
                    data: value["ctr_array"]
                  }
                  end
        
    {           
        labels: @dates,            
              datasets: 
                    dataset_array
                  }
      end

       def make_graph_conv_rate
        i = -1
        dataset_array = @graph_package.map do |key, value |
                  colors = ["rgba(232,111,12,1)", "rgba(12,151,232,1)", "rgba(232,12,96,1)", "rgba(232,184,12,1)", "rgba(222,124,0,.8)", "rgba(0,0,0,.8)", "rgba(80,158,47,.8)"]
                  i += 1
                  {
                    label: key,
                    yAxisID: "y-axis-2",
                    backgroundColor: "rgba(220,220,220,0.2)",
                    borderColor: colors[i],
                    data: value["conversion_rate_array"]
                  }
                  end
        
    {           
        labels: @dates,            
              datasets: 
                    dataset_array
                  }
      end


       def make_graph_cpa
        i = -1
        dataset_array = @graph_package.map do |key, value |
                  colors = ["rgba(232,111,12,1)", "rgba(12,151,232,1)", "rgba(232,12,96,1)", "rgba(232,184,12,1)", "rgba(222,124,0,.8)", "rgba(0,0,0,.8)", "rgba(80,158,47,.8)"]
                  i += 1
                  {
                    label: key,
                    yAxisID: "y-axis-2",
                    backgroundColor: "rgba(220,220,220,0.2)",
                    borderColor: colors[i],
                    data: value["cpa_array"]
                  }
                  end
        
    {           
        labels: @dates,            
              datasets: 
                    dataset_array
                  }
      end


       def make_graph_cpc
        i = -1
        dataset_array = @graph_package.map do |key, value |
                  colors = ["rgba(232,111,12,1)", "rgba(12,151,232,1)", "rgba(232,12,96,1)", "rgba(232,184,12,1)", "rgba(222,124,0,.8)", "rgba(0,0,0,.8)", "rgba(80,158,47,.8)"]
                  i += 1
                  {
                    label: key,
                    yAxisID: "y-axis-2",
                    backgroundColor: "rgba(220,220,220,0.2)",
                    borderColor: colors[i],
                    data: value["cpa_array"]
                  }
                  end
        
    {           
        labels: @dates,            
              datasets: 
                    dataset_array
                  }
      end
end