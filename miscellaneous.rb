

 formatted_hashes1.concat(formatted_hashes2)

almost_final_hash = x.group_by do |hash|
hash[:name]
end

 almost_final_hash.values.map do |array|
 array[0].merge(array[1])
 end
