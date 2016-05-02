require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/headcount_analyst'
require_relative '../lib/district_repository'

class HeadcountAnalystTest < Minitest::Test

  def setup
    @dr = DistrictRepository.new
    @dr.load_data(
    {
      :enrollment =>
        {
          :kindergarten => "./test/data/kindergarten.csv",
          :high_school_graduation => "./test/data/parser_high_school_data.csv"
        },
      :statewide_testing =>
        {
          :third_grade=> "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
          :eighth_grade=> "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
          :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
          :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
          :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
        },
      :economic_profile =>
        {
          :median_household_income => "./data/Median household income.csv",
          :children_in_poverty => "./data/School-aged children in poverty.csv",
          :free_or_reduced_price_lunch => "./data/Students qualifying for free or reduced price lunch.csv",
          :title_i => "./data/Title I students.csv"
        }
    })
    @ha = HeadcountAnalyst.new(@dr)
  end

  def test_it_can_find_average_enrollment_for_a_district
    average_enrollment = @ha.average_enrollment_kindergarten("ACADEMY 20")
    assert_equal 0.337, average_enrollment
  end

  def test_it_can_find_kindergarten_participation_rate_variation
    assert_equal 1.002, @ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'COLORADO')
    assert_equal 1.124, @ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'ADAMS COUNTY 14')
  end

  def test_it_can_find_variation_trends
    hash = {2007 => 0.992, 2006 => 1.050, 2005 => 0.960}
    assert_equal hash, @ha.kindergarten_participation_rate_variation_trend('ACADEMY 20', :against => 'COLORADO')
  end

  def test_it_can_find_variation_between_kindergarten_and_high_school_graduation
    assert_equal 0.819, @ha.kindergarten_participation_against_high_school_graduation("ACADEMY 20")
  end

  def test_it_can_determine_if_kindergarten_correlates_with_high_school_graduation
    assert_equal true, @ha.kindergarten_participation_correlates_with_high_school_graduation(for: "ACADEMY 20")
  end

  def test_it_can_determine_if_kindergarten_correlates_with_high_school_graduation_statewide
    assert_equal true, @ha.kindergarten_participation_correlates_with_high_school_graduation(for: "STATEWIDE")
  end

  def test_it_can_calculate_correlation_across_a_subset_of_districts
    assert_equal true, @ha.kindergarten_participation_correlates_with_high_school_graduation(across: ['ACADEMY 20','ADAMS COUNTY 14'])
  end

end
