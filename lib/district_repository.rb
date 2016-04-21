require 'csv'
require './lib/district'
require 'pry'

class DistrictRepository
  attr_accessor :districts

  def initialize
    @districts = []
  end

  def find_by_name(name)
      districts.find { |d| d.name == name }
  end

  def load_data(data)
    kindergarten_file = data[:enrollment][:kindergarten]
    raw_csv_data = CSV.open(kindergarten_file,
    headers: true, header_converters: :symbol).map(&:to_h)


    formatted = raw_csv_data.each do |hash|
      name = hash[:location]
      d = District.new({name: name})
      @districts << d
    end
    @districts
    binding.pry
  end


    #raw_data = array of hashes
    #we want to just take the name
    #put it into a hash with key :name and value "district name"
    #and then populate district objects with this data

end
