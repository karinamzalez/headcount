require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/parser_median_income'
require_relative '../lib/simplify_parsers_module'
require 'csv'

class ParserMedianIncomeTest < Minitest::Test
  include ParserMedianIncome
  include SimplifyParsers

  def test_it_can_format_each_median_income_line_into_a_hash
    output =
    [
      {
        :name=>"Colorado",
        :median_household_income=>{[2005, 2009]=>56222}
      },
      {
        :name=>"Colorado",
        :median_household_income=>{[2006, 2010]=>56456}
      },
      {
        :name=>"ACADEMY 20",
        :median_household_income=>{[2005, 2009]=>85060}
      },
      {
        :name=>"ACADEMY 20",
        :median_household_income=>{[2006, 2010]=>85450}
      },
      {
        :name=>"ADAMS COUNTY 14",
        :median_household_income=>{[2005, 2009]=>41382}
      },
      {
        :name=>"ADAMS COUNTY 14",
        :median_household_income=>{[2006, 2010]=>40740}
      },
      {
        :name=>"ADAMS-ARAPAHOE 28J",
        :median_household_income=>{[2005, 2009]=>43893}
      },
      {
        :name=>"ADAMS-ARAPAHOE 28J",
        :median_household_income=>{[2006, 2010]=>44007}
      },
      {
        :name=>"AGATE 300",
        :median_household_income=>{[2005, 2009]=>64167}
      },
      {
        :name=>"AGATE 300",
        :median_household_income=>{[2006, 2010]=>64145}
      }
    ]
    assert_equal output, format_median_income_hash_per_line('./test/data/median_household_income.csv', "median_household_income" )
  end
end
