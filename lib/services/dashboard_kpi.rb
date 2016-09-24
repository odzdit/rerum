class DashboardKpi
	def initialize(array)
		@array = array
	end

	def reduce_array
		@array.reduce(0)  { 
	      | sum, x | sum + x.to_i
	    }
	end
end

