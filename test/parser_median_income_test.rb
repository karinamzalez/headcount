require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/parser_median_income'
require 'csv'

class ParserMedianIncomeTest < Minitest::Test
  include ParserMedianIncome

  def test_it_can_get_raw_data_from_csv_file
    output=
    [
      {
        :location=>"Colorado", :timeframe=>"2005-2009",
        :dataformat=>"Currency", :data=>"56222"
      },
      {
        :location=>"Colorado", :timeframe=>"2006-2010",
        :dataformat=>"Currency", :data=>"56456"
      },
      {
        :location=>"ACADEMY 20", :timeframe=>"2005-2009",
        :dataformat=>"Currency", :data=>"85060"
      },
      {
        :location=>"ACADEMY 20", :timeframe=>"2006-2010",
        :dataformat=>"Currency", :data=>"85450"
      },
      {
        :location=>"ADAMS COUNTY 14", :timeframe=>"2005-2009",
        :dataformat=>"Currency", :data=>"41382"
      },
      {
        :location=>"ADAMS COUNTY 14", :timeframe=>"2006-2010",
        :dataformat=>"Currency", :data=>"40740"
      },
      {
        :location=>"ADAMS-ARAPAHOE 28J", :timeframe=>"2005-2009",
        :dataformat=>"Currency", :data=>"43893"
      },
      {
        :location=>"ADAMS-ARAPAHOE 28J", :timeframe=>"2006-2010",
        :dataformat=>"Currency", :data=>"44007"
      },
      {
        :location=>"AGATE 300", :timeframe=>"2005-2009",
        :dataformat=>"Currency", :data=>"64167"
      },
      {
        :location=>"AGATE 300", :timeframe=>"2006-2010",
        :dataformat=>"Currency", :data=>"64145"
      }
    ]
    assert_equal output, get_raw_data('./test/data/median_household_income.csv')
  end

  def test_it_can_delete_data_format
    output =
    [
      {
        :location=>"Colorado",
        :timeframe=>"2005-2009",
        :data=>"56222"
      },
      {
        :location=>"Colorado",
        :timeframe=>"2006-2010",
        :data=>"56456"
      },
      {
        :location=>"ACADEMY 20",
        :timeframe=>"2005-2009",
        :data=>"85060"
      },
      {
        :location=>"ACADEMY 20",
        :timeframe=>"2006-2010",
        :data=>"85450"
      },
      {
        :location=>"ADAMS COUNTY 14",
        :timeframe=>"2005-2009",
        :data=>"41382"
      },
      {
        :location=>"ADAMS COUNTY 14",
        :timeframe=>"2006-2010",
        :data=>"40740"
      },
      {
        :location=>"ADAMS-ARAPAHOE 28J",
        :timeframe=>"2005-2009",
        :data=>"43893"
      },
      {
        :location=>"ADAMS-ARAPAHOE 28J",
        :timeframe=>"2006-2010",
        :data=>"44007"
      },
      {
        :location=>"AGATE 300",
        :timeframe=>"2005-2009",
        :data=>"64167"
      },
      {
        :location=>"AGATE 300",
        :timeframe=>"2006-2010",
        :data=>"64145"
      }
    ]
    assert_equal output, delete_dataformat('./test/data/median_household_income.csv')
  end

  def method_name

  end
end
