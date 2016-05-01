gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/economic_profile_repository'
require_relative '../lib/economic_profile'
require_relative '../lib/economic_formatter'
require_relative '../lib/statewide_testing_formatter'
require_relative '../lib/parser_subject_proficiency'
require_relative '../lib/simplify_parsers_module'
require_relative '../lib/parser_enrollment'
require_relative '../lib/parser_poverty_data'
require_relative '../lib/parser_median_income'
require_relative '../lib/parser_free_reduced'
require_relative '../lib/parser_grade'


class EconomicProfileRepositoryTest < Minitest::Test
  include EconomicFormatter
  include StatewideTestingFormatter
  include ParserSubjectProficiency
  include SimplifyParsers
  include ParserEnrollment
  include ParserPovertyData
  include ParserMedianIncome
  include ParserFreeReduced
  include ParserGrade

  def setup
    @epr = EconomicProfileRepository.new
    @repo_data =
      {
        :economic_profile => {
          :median_household_income => "./test/data/median_household_income.csv",
          :children_in_poverty => "./test/data/poverty.csv",
          :free_or_reduced_price_lunch => "./test/data/lunch.csv",
          :title_i => "./test/data/title_i.csv"
        }
      }

      profile_data =
        {
          :median_household_income =>
            {[2005, 2009] => 50000, [2008, 2014] => 60000},
          :children_in_poverty =>
            {2012 => 0.184},
          :free_or_reduced_price_lunch =>
            {2014 => {:percentage => 0.023, :total => 100}},
          :title_i =>
            {2015 => 0.543},
          :name => "ACADEMY 20"
        }

      @ep = EconomicProfile.new(profile_data)
  end

  def test_a_new_economic_profile_repo_has_no_economic_profile_objects
    assert_equal [], @epr.economic_profiles
  end

  def test_it_can_find_an_economic_profile_by_name
    @epr.economic_profiles << @ep
    assert_equal "ACADEMY 20", @epr.find_by_name("ACADEMY 20").name
  end

  def test_it_returns_nil_if_no_economic_profile_object_exists_with_given_name
    @epr.economic_profiles << @ep
    assert_equal nil, @epr.find_by_name("hello")
  end

  def test_it_can_find_by_name_case_insensitive
    @epr.economic_profiles << @ep
    assert_equal "ACADEMY 20", @epr.find_by_name("Academy 20").name
  end

  def test_it_can_load_data_via_csv
    @epr.load_data(@repo_data)
    assert_equal 5, @epr.economic_profiles.count
  end

  def test_it_can_access_information_from_econ_profile_objects
    @epr.load_data(@repo_data)
    ep = @epr.find_by_name("ACADEMY 20")
    assert_equal , ep.median_household_income_in_year()
    assert_equal , children_in_poverty_in_year()
    assert_equal , free_or_reduced_price_lunch_percentage_in_year(year)
    assert_equal
  end

end
