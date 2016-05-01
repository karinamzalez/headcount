
require_relative '../lib/economic_formatter'
require_relative '../lib/economic_formatter'
require_relative '../lib/statewide_testing_formatter'
require_relative '../lib/parser_subject_proficiency'
require_relative '../lib/simplify_parsers_module'
require_relative '../lib/parser_enrollment'
require_relative '../lib/parser_poverty_data'
require_relative '../lib/parser_median_income'
require_relative '../lib/parser_free_reduced'
require_relative '../lib/parser_grade'

class EconomicProfileRepository
  include EconomicFormatter
  include StatewideTestingFormatter
  include ParserSubjectProficiency
  include SimplifyParsers
  include ParserEnrollment
  include ParserPovertyData
  include ParserMedianIncome
  include ParserFreeReduced
  include ParserGrade

  attr_reader :economic_profiles

  def initialize
    @economic_profiles = []
  end

  def find_by_name(name)
    @economic_profiles.find { |profile| profile.name == name.upcase}
  end

  def load_data(data)
    merge_all_economic_data(data).each do |hash|
      @economic_profiles << EconomicProfile.new(hash)
    end
  end


end
