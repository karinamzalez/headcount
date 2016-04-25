require_relative '../lib/statewide_test'

class StatewideTestRepository
  attr_reader :statewide_tests
  def initialize
    @statewide_tests = []
  end

  def find_by_name(name)
    statewide_tests.find { |state_tests| state_tests.name == name.upcase }
  end

  def load_data(data)
    #don't need an if statement b/c we'll load all the files at once
    #want to get all the grade data and race data into one hash
          #after we get individual data from parser
    formatted_hashes.each do |hash|
      @statewide_tests << StatewideTest.new(hash)
    end
  end
end
