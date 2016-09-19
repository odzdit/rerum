
def currency_converter(array)
	array.map do |cost|
		new_cost = cost.to_i
		decimal_cost = new_cost/1000000
		p decimal_cost.to_f
	end
end

# def micro_currency(cost)
# 	cost.self.to_i/100000
# 	cost.to_f
# end
