gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/economic_profile_repository'
require_relative '../lib/economic_profile'

class EconomicRepositoryTest < Minitest::Test

  def setup
    @epr = EconomicProfileRepository.new
    @repo_data =
      {
        :economic_profile => {
          :median_household_income => "./data/Median household income.csv",
          :children_in_poverty => "./data/School-aged children in poverty.csv",
          :free_or_reduced_price_lunch => "./data/Students qualifying for free or reduced price lunch.csv",
          :title_i => "./data/Title I students.csv"
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
    skip
    @epr.load_data(@repo_data)
    assert_equal "number", @er.enrollments.count
    assert_equal 
  end


end
