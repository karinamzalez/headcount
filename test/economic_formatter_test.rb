gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/economic_formatter'

class EconomicFormatterTest < Minitest::Test
  include StatewideTestingFormatter
  include ParserSubjectProficiency
  include ParserGrade
  include SimplifyParsers
  include ParserEnrollment
  include EconomicFormatter

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

  # def test_it_can_merge_the_poverty_data_by_dsitrcit
  #   skip
  #   assert_equal "", merge_poverty_file(@data)
  # end

  # def test_it_can_merge_title_i_data_by_district
  #   assert_equal "", merge_title_i_file(@data)
  # end
  #
  # def test_it_can_gather_all_data_into_one_array
  #
  # end
  #
  # def test_it_can_format_to_final_economic_hashes
  #
  # end

end
