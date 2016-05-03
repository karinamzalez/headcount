require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/headcount_analyst'
require_relative '../lib/district_repository'

class HeadcountAnalystTest < Minitest::Test

  def setup
    @dr = DistrictRepository.new
    @data =
    {
      :enrollment =>
        {
          :kindergarten => "./test/data/kindergarten.csv",
          :high_school_graduation => "./test/data/parser_high_school_data.csv"
        },
      :statewide_testing =>
        {
          :third_grade=> "./test/data/3rd_grade_scores.csv",
          :eighth_grade=> "./test/data/8th_grade_scores.csv",
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
    }
    @dr.load_data(@data)
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

  def test_it_can_get_the_grade
    assert_equal 3, @ha.get_grade(grade: 3)
  end

  def test_you_must_provide_a_grade
    assert_raises(InsufficientInformationError) do
      @ha.get_grade(subject: :math)
    end
  end

  def test_it_can_get_the_subject
    assert_equal :math,
    @ha.get_subject(subject: :math)
  end

  def test_it_can_truncate_percents
    assert_equal 0.123, @ha.truncate_percents(0.12345)
  end

  def test_it_does_not_include_statewide_data
    data =
    [
      ["COLORADO", 0.123],
      ["ACADEMY 20", 0.345]
    ]
    refute @ha.ignore_statewide_data(data).flatten.include?("COLORADO")
  end

  def test_it_can_find_percentage_growth_for_one_district
    @dr.load_data(@data)
    d = @dr.districts[0]
    assert_equal (-0.006),
    @ha.find_percentage_growth_for_one_district({grade: 3, subject: :math}, d)
  end


  def test_it_can_find_a_single_leading_district_in_test_proficiency_growth
    assert_equal ["ADAMS-ARAPAHOE 28J", -0.016],
    @ha.top_statewide_test_year_over_year_growth(grade: 3, subject: :math)
  end

  def test_it_can_find_the_top_3_districts_in_growth
    data =
    [
      ["ADAMS-ARAPAHOE 28J", -0.016],
      ["ADAMS COUNTY 14", -0.02],
      ["ACADEMY 20", -0.033]
    ]
    assert_equal data,
    @ha.top_statewide_test_year_over_year_growth(grade: 3, top: 3, subject: :math)
  end

  def test_it_can_find_a_different_number_of_top_districts
    data =
    [
      ["ADAMS-ARAPAHOE 28J", -0.016],
      ["ADAMS COUNTY 14", -0.02],
    ]
    assert_equal data,
    @ha.top_statewide_test_year_over_year_growth(grade: 3, top: 2, subject: :math)
  end

  def test_it_can_find_the_top_district_across_all_subjects
    assert_equal ["ADAMS-ARAPAHOE 28J", 0.006],
    @ha.top_statewide_test_year_over_year_growth(grade: 3)
  end

  def test_it_can_calculate_total_subject_prof_average_for_one_district
    d = @dr.find_by_name("ACADEMY 20")
    assert_equal ["ACADEMY 20", 0.033],
    @ha.percentage_growth_across_all_subjects_for_district({grade: 3}, d)
  end

end
