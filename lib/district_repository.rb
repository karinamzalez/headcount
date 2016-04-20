require 'csv'
require './lib/district'

class DistrictRepository
  attr_accessor :districts

  def initialize
    @districts = []
  end

  def find_by_name(name)
      districts.find { |d| d.name == name }
  end

end
