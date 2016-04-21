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

    grouped = raw_csv_data.group_by do |hash|
      hash[:location]
    end

    district_names = grouped.keys

    district_names.each do |name|
      d = District.new({name: name})
      @districts << d
    end
    @districts
  end

  def arion


end
