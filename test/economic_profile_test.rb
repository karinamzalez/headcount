require 'simplecov'
SimpleCov.start

gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/economic_profile'

class EconomicProfileTest < Minitest::Test

  def setup
    data =
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
    @ep = EconomicProfile.new(data)
  end

  def test_it_can_give_its_name
    assert_equal "ACADEMY 20", @ep.name
  end

  def test_it_can_return_an_array_of_all_incomes_matching_year
    assert_equal [50000], @ep.get_income_associated_with_year(2005)
    assert_equal [50000, 60000], @ep.get_income_associated_with_year(2009)
  end

  def test_it_can_see_if_the_given_year_is_included_in_year_ranges
    assert @ep.get_all_years(2006)
    assert @ep.get_all_years(2009)
    refute @ep.get_all_years(1910)
  end

  def test_it_can_give_median_household_income_in_a_given_year
    assert_equal 50000, @ep.median_household_income_in_year(2005)
    assert_equal 55000, @ep.median_household_income_in_year(2009)
  end

  def assert_it_raises_error_if_given_unknown_year
    assert_raises(UnknownDataError) do
      @ep.median_household_income_in_year(1910)
    end
  end

  def test_it_can_give_the_median_household_income_average
    assert_equal 55000, @ep.median_household_income_average
  end

  def test_it_can_give_percent_of_children_in_poverty_for_a_given_year
    assert_equal 0.184, @ep.children_in_poverty_in_year(2012)
  end

  def test_it_raises_error_if_not_a_valid_poverty_year
    assert_raises(UnknownDataError) do
      @ep.children_in_poverty_in_year(1910)
    end
  end

  def test_it_can_find_reduced_lunch_percentage_for_a_given_year
    assert_equal 0.023, @ep.free_or_reduced_price_lunch_percentage_in_year(2014)
  end

  def test_it_raises_error_if_invalid_lunch_year
    assert_raises(UnknownDataError) do
      @ep.free_or_reduced_price_lunch_percentage_in_year(1910)
    end
  end

  def test_it_can_give_the_reduced_lunch_number_for_a_given_year
    assert_equal 100, @ep.free_or_reduced_price_lunch_number_in_year(2014)
  end

  def test_it_raises_an_error_if_given_invalid_lunch_number_year
    assert_raises(UnknownDataError) do
      @ep.free_or_reduced_price_lunch_number_in_year(1910)
    end
  end

  def test_it_can_give_title_i_data_for_a_given_year
    assert_equal 0.543, @ep.title_i_in_year(2015)
  end

  def test_it_raises_error_if_given_invaluid_title_i_year
    assert_raises(UnknownDataError) do
      @ep.title_i_in_year(1910)
    end
  end

end
