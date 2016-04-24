

 formatted_hashes1.concat(formatted_hashes2)

almost_final_hash = x.group_by do |hash|
hash[:name]
end

 almost_final_hash.values.map do |array|
 array[0].merge(array[1])
 end



 file_hash = data[:enrollment].keys.map do |key|
   if key == :kindergarten
     formatted_hashes1 = format_file_to_hash_kindergarten(kindergarten_file(data))
   else
     formatted_hashes2 = format_file_to_hash_high_school(graduation_file(data))
     x = formatted_hashes1.concat(formatted_hashes2)
   end
   file_hash = formatted_hashes1
   require "pry"; binding.pry
