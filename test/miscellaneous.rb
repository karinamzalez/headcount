raw_data = [{:location=>"d1", :timeframe=>"2010", :dataformat=>"Percent", :data=>"1"},
            {:location=>"d1", :timeframe=>"2011", :dataformat=>"Percent", :data=>"1"},
            {:location=>"d2", :timeframe=>"2012", :dataformat=>"Percent", :data=>"1"},
            {:location=>"d2", :timeframe=>"2013", :dataformat=>"Percent", :data=>"0.9983"}
          ]

new_data = raw_data.map do |hash|
  hash.delete(:dataformat)
  hash
end

new2 = new_data.map do |hash|
  {name: h[:location], kindergarten: {h[:timeframe] => h[:data]}}
end

grouped = new2.group_by do |hash|
  hash[:name]
end

merged = grouped.map do |location, entries|
  {name: location, kindergarten_participation: merged_entries(entries)}
end

def merged_entries(entries)
  entries.map do |e|
    e[:kindergarten]
  end.reduce(:merge)
end

puts merged

# entries:
#[{:name=>"d1", :kindergarten=>{"2010"=>"1"}}, {:name=>"d1", :kindergarten=>{"2011"=>"1"}}]
# want: {"2010" => "1", "2011" => "1"}

# location: "d1" <something like...>
# entries: [{:name=>"d1", :kindergarten=>{"2010"=>"1"}}, {:name=>"d1", :kindergarten=>{"2011"=>"1"}}]
# want this structure:
# {:name => "d1", :kindergarten_participation => {"2010" => "1", "2011" => "1"}}
# fill in the blanks:
# {:name => ________, :kindergarten_participation => ________}


# puts new2.inspect
#returns an array of hashes like this:
#[{:name=>"d1", :kindergarten=>{"2010"=>"1"}},
# {:name=>"d1", :kindergarten=>{"2011"=>"1"}}]


# require "pry"; binding.pry
# new_guy = new2.group_by {|new2_hash| new2_hash[:name]}
# puts new_guy.inspect
  # new_guy = new2.inject(Hash.new()) do |hash, i|
  #  hash[:name] ||= []
  #  hash[:name] += [i[:name]]
  #  hash[:kindergarten] ||= {}
  #  hash[:kindergarten] = hash[:kindergarten].merge(i[:kindergarten])
  #  hash[:name].uniq!
  #  hash
 #  new_guy = new2.inject(Hash.new({})) do |hash, i|
 #   hash[:name] = i[:name]
 #   hash[:kindergarten] = hash[:kindergarten].merge(i[:kindergarten])
 #   hash
 # end
 # puts new_guy.inspect
