require_relative '../lib/statewide_test'
require "csv"
require_relative '../lib/parser_grade'
require_relative '../lib/parser_subject_proficiency'
require_relative '../lib/statewide_testing_formatter'


class StatewideTestRepository
  include ParserSubjectProficiency
  include ParserGrade
  include StatewideTestingFormatter

  attr_reader :statewide_tests

  def initialize
    @statewide_tests = []
  end

  def find_by_name(name)
    statewide_tests.find { |state_tests| state_tests.name == name.upcase }
  end

  def load_data(data)
    merge_all_data(data).each do |hash|
      @statewide_tests << StatewideTest.new(hash)
    end
  end

end
