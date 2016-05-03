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
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./data/High school graduation rates.csv",
      },
       :statewide_testing =>
       {
         :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
         :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
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
    assert_equal 0.4060909090909091, average_enrollment
  end

  def test_it_can_find_kindergarten_participation_rate_variation
    assert_equal 0.766, @ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'COLORADO')
    assert_equal 0.572, @ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'ADAMS COUNTY 14')
  end

  def test_it_can_find_variation_trends
    hash = {2007=>0.992, 2006=>1.05, 2005=>0.96, 2004=>1.258, 2008=>0.717, 2009=>0.652, 2010=>0.681, 2011=>0.727, 2012=>0.687, 2013=>0.693, 2014=>0.661}
    assert_equal hash, @ha.kindergarten_participation_rate_variation_trend('ACADEMY 20', :against => 'COLORADO')
  end

  def test_it_can_find_variation_between_kindergarten_and_high_school_graduation
    assert_equal 0.641, @ha.kindergarten_participation_against_high_school_graduation("ACADEMY 20")
  end

  def test_it_can_determine_if_kindergarten_correlates_with_high_school_graduation
    assert_equal true, @ha.kindergarten_participation_correlates_with_high_school_graduation(for: "ACADEMY 20")
  end

  def test_it_can_determine_if_kindergarten_correlates_with_high_school_graduation_statewide
    assert_equal false, @ha.kindergarten_participation_correlates_with_high_school_graduation(for: "STATEWIDE")
  end

  def test_it_can_calculate_correlation_across_a_subset_of_districts
    assert_equal false, @ha.kindergarten_participation_correlates_with_high_school_graduation(across: ['ACADEMY 20','ADAMS COUNTY 14'])
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
    assert_equal (0.0029999999999999996),
    @ha.find_percentage_growth_for_one_district({grade: 3, subject: :math}, d)
  end

  def test_it_can_find_a_single_leading_district_in_test_proficiency_growth
    assert_equal ["YUMA SCHOOL DISTRICT 1", -0.020666666666666667],
    @ha.top_statewide_test_year_over_year_growth(grade: 3, subject: :math)
  end

  def test_it_can_find_the_total_subject_proficiency_percent_for_first_year_of_one_district
    d = @dr.find_by_name("ACADEMY 20")
    assert_equal 0.798 ,
    @ha.get_total_subject_percent_for_first_year({grade: 3}, d)
  end

  def test_it_can_get_top_three_poverty_stricken_districts
    data =
    [
      ["AGUILAR REORGANIZED 6", 0.389],
      ["MOFFAT 2", 0.368],
      ["MANZANOLA 3J", 0.358]
    ]
    assert_equal data, @ha.top_or_bottom_three_poverty_stricken_districts(top: 3)
  end

  def test_it_can_get_bottom_three_poverty_stricken_districts
    data =
      [
        ["DOUGLAS COUNTY RE 1", 0.027],
        ["ASPEN 1", 0.038],
        ["ACADEMY 20", 0.041]
      ]
    assert_equal data, @ha.top_or_bottom_three_poverty_stricken_districts(bottom: 3)
  end

  def test_it_can_find_corresponding_test_scores_for_top_and_bottom
    data =
    [
      [
        "AGUILAR REORGANIZED 6",
        {
          2011=>{:math=>0.41, :reading=>0.5, :writing=>0.369},
          2012=>{:math=>0.266, :reading=>0.425, :writing=>0.177},
          2013=>{:math=>0.325, :reading=>0.465, :writing=>0.325},
          2014=>{:math=>0.214, :reading=>0.464, :writing=>0.196}
        }
      ],
      [
        "MOFFAT 2",
        {
          2011=>{:math=>0.49, :reading=>0.72, :writing=>0.508},
          2012=>{:math=>0.482, :reading=>0.719, :writing=>0.5},
          2013=>{:math=>0.575, :reading=>0.725, :writing=>0.522},
          2014=>{:math=>0.5, :reading=>0.715, :writing=>0.47}
        }
      ],
      [
        "MANZANOLA 3J",
        {
          2011=>{:math=>0.4, :reading=>0.49, :writing=>0.356},
          2012=>{:math=>0.296, :reading=>0.527, :writing=>0.34},
          2013=>{:math=>0.405, :reading=>0.567, :writing=>0.378},
          2014=>{:math=>0.353, :reading=>0.567, :writing=>0.358}
        }
      ]
    ]
    assert_equal data, @ha.corresponding_test_scores_for_districts(top: 3)
  end

  def test_it_can_condense_test_scores_per_district_to_one_avg_per_subject
    data = [0.303, 0.511, 0.363]
    assert_equal data, @ha.almost_condensed(:math, top: 3)
  end

  def test_it_can_condense_test_cores_to_one_avg_per_subject_for_top_3_impoverished
    data =
    {
      :top_3_impoverished=>
      {:math=>0.392, :reading=>0.573, :writing=>0.374}
    }
    assert_equal data, @ha.condensed_test_scores(top: 3)
  end

  def test_it_can_condense_test_cores_to_one_avg_per_subject_for_bottom_3_impoverished
    data =
      {
        :bottom_3_impoverished=>
        {
          :math=>0.705, :reading=>0.836, :writing=>0.704
        }
      }
    assert_equal data, @ha.condensed_test_scores(bottom: 3)
  end

  def test_it_compares_the_top_and_bottom_3_districts
    data =
      {
        :math=>0.556,
        :reading=>0.685,
        :writing=>0.531
      }
    assert_equal data, @ha.comparison_of_test_scores_based_upon_poverty
  end

end
