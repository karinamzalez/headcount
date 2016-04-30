gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/economic_formatter'
require_relative '../lib/statewide_testing_formatter'
require_relative '../lib/parser_subject_proficiency'
require_relative '../lib/parser_grade'
require_relative '../lib/simplify_parsers_module'
require_relative '../lib/parser_enrollment'
require_relative '../lib/parser_poverty_data'
require_relative '../lib/parser_median_income'

class EconomicFormatterTest < Minitest::Test
  include StatewideTestingFormatter
  include ParserSubjectProficiency
  include ParserGrade
  include SimplifyParsers
  include ParserEnrollment
  include EconomicFormatter
  include ParserPovertyData
  include ParserMedianIncome

  def setup
    @data =
  {
    :economic_profile =>
    {
      :median_household_income => "./test/data/median_household_income.csv",
      :children_in_poverty => "./test/data/poverty.csv",
      :free_or_reduced_price_lunch => "./test/data/lunch.csv",
      :title_i => "./test/data/title_i.csv"
    }
  }
  end

  def test_it_can_find_the_median_income_file
    assert_equal "./test/data/median_household_income.csv", income_file(@data)
  end

  def test_it_can_find_the_poverty_file
    assert_equal "./test/data/poverty.csv", poverty_file(@data)
  end

  def test_it_can_find_the_lunch_file
    assert_equal "./test/data/lunch.csv", lunch_file(@data)
  end

  def test_it_can_find_the_title_i_file
    assert_equal "./test/data/title_i.csv", title_i_file(@data)
  end

  def test_it_can_merge_the_poverty_data_by_dsitrcit
    data =
    [
      {:name=>"ACADEMY 20",
       :children_in_poverty=>{2007=>0.039, 2008=>0.044}},
      {:name=>"ADAMS COUNTY 14",
       :children_in_poverty=>{2007=>0.247, 2008=>0.225}},
      {:name=>"ADAMS-ARAPAHOE 28J",
       :children_in_poverty=>{2007=>0.238, 2008=>0.185}}
    ]
      assert_equal data, merge_poverty_hashes(@data)
  end

  def test_it_can_merge_the_median_income_dat_by_distrcit
    data =
    [
      {:name=>"Colorado",
       :median_household_income=>{[2005, 2009]=>56222, [2006, 2010]=>56456}},
      {:name=>"ACADEMY 20",
       :median_household_income=>{[2005, 2009]=>85060, [2006, 2010]=>85450}},
      {:name=>"ADAMS COUNTY 14",
       :median_household_income=>{[2005, 2009]=>41382, [2006, 2010]=>40740}},
      {:name=>"ADAMS-ARAPAHOE 28J",
       :median_household_income=>{[2005, 2009]=>43893, [2006, 2010]=>44007}},
      {:name=>"AGATE 300",
       :median_household_income=>{[2005, 2009]=>64167, [2006, 2010]=>64145}}
    ]
    assert_equal data, merge_income_hashes(@data)
  end

  def test_it_can_merge_title_i_data_by_district
    skip
    assert_equal "", merge_title_i_file(@data)
  end

  def test_it_can_gather_all_data_into_one_array
    skip
  end

  def test_it_can_format_to_final_economic_hashes
    skip
  end

end
