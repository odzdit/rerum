colors =[ "rgba(49,115,125,.8)", "rgba(49,115,125,.8)", "rgba(49,115,125,.8)"]

0.upto(6).each do | color |
puts "rgba(" + (49 + color ).to_s + "," + (115 + color).to_s + "," + (125 + color).to_s + "," + ".8)"
end
