class DashboardKpi
	def initialize(data)
		@data = data
	end

	def package
		@package = {
			:days => [],
			:clicks => 0,
			:impressions => 0,
			:conversions => 0,
			:cost => 0,
			:clicks_array => [],
			:conversions_array => [],
			:impressions_array => [],
			:cost_array => []
		} 
		@data.each do |data_point|
			@package[:clicks] += data_point[1][:clicks].to_i
			@package[:impressions] += data_point[1][:impressions].to_i
			@package[:conversions] += data_point[1][:conversions].to_i
			@package[:cost] += data_point[1][:cost].to_i
			@package[:days].push data_point[0]

			@package[:clicks_array].concat([data_point[1][:clicks].to_i])
			@package[:impressions_array].concat([data_point[1][:impressions].to_i])
			@package[:conversions_array].concat([data_point[1][:conversions].to_i])
			@package[:cost_array].concat([data_point[1][:cost].to_i/1000000])


		end
		@package[:cost] = @package[:cost] / 1000000

		@package[:ctr] = @package[:clicks] / @package[:impressions]
		@package[:cpc] = @package[:cost] / @package[:clicks]
		@package[:cpa] = @package[:cost] / @package[:conversions] rescue 0
		@package[:conv_rate]  = @package[:conversions] / @package[:clicks] rescue 0
		return @package
	end


end

