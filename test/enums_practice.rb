require 'pry'
raw_data = [{:location=>"d1", :timeframe=>"2010", :dataformat=>"Percent", :data=>"1"},
            #reduce this to {:location=> "d1", :kinderg_part => {2010 => 1}}
            #new_data[:kinderg_part = {[raw_data[:timeframe] => raw_data[:data]}]
            {:location=>"d1", :timeframe=>"2011", :dataformat=>"Percent", :data=>"1"},
            {:location=>"d2", :timeframe=>"2012", :dataformat=>"Percent", :data=>"1"},
            {:location=>"d2", :timeframe=>"2013", :dataformat=>"Percent", :data=>"0.9983"}
          ]

new_data = raw_data.map do |hash|
  hash.delete(:dataformat)
  hash
end
# puts new_data

new2 = new_data.map do |hash|
  new_3 = {}
  new_3[:name] = hash[:location]
  new_3[:kindergarten] = {hash[:timeframe] => hash[:data]}
  new_3
end

#if we can isolate all the lines with the same district name, we can do this:
new_guy = new2.inject(Hash.new({})) do |hash, i|
  hash[:name] = i[:name]
  hash[:kindergarten] = hash[:kindergarten].merge(i[:kindergarten])
  hash
end
# puts new_guy.inspect

# puts new2.inspect
#returns an array of hashes like this:
#[{:name=>"d1", :kindergarten=>{"2010"=>"1"}},
# {:name=>"d1", :kindergarten=>{"2011"=>"1"}}]
#how do we get it all in one???


#until hash[:location] != hash[:location]
#shovel the line into a new array
# binding.pry
new2.each do |hash|
  until hash[:name] != hash[:name]
    found_names = new2.find_all do |hash|
      hash[:name]
    end
  end
end
#
puts found_names.inspect

#find_all hashes with the same value at key :name (district name)
# return an array of these hashes




#==================================================================

# new_guy = new2.group_by {|new2_hash| new2_hash[:name]}
# puts new_guy.inspect
#
# #for each row of the data,
# #build the hash the way we want it
#
# new_h = {}
# raw_data.map do |hash|
#   new_h[:name] = hash[:location]
#   new_h[:kindergarten] = {hash[:timeframe] => hash[:data]}
#   new_h
# end
#
# puts new_h.inspect

#data.fetch(district_name)

#update if there is a new name
#if this data already has a key, don't do this, but if it does
