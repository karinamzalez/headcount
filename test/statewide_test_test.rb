gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/statewide_test'

class StatewideTestTest < Minitest::Test

  def setup
    @st = StatewideTest.new(
    {
      :name => "ACADEMY 20",
      :third_grade_proficiency =>
      {
       2008 => {:math => 0.857, :reading => 0.866, :writing => 0.671},
       2009 => {:math => 0.824, :reading => 0.862, :writing => 0.706}
      },
      :asian_proficiency =>
      {
       2011 => {math: 0.816, reading: 0.897, writing: 0.826},
       2012 => {math: 0.818, reading: 0.893, writing: 0.808}
      }
    })
  end

  def test_it_can_return_test_data_for_grade
    data =
    {
     2008 => {:math => 0.857, :reading => 0.866, :writing => 0.671},
     2009 => {:math => 0.824, :reading => 0.862, :writing => 0.706},
    }
   assert_equal data, @st.proficient_by_grade(3)
  end

  def test_it_raises_an_error_if_grade_unknown
    assert_raises(UnknownDataError) do
      @st.proficient_by_grade(5)
    end
  end

  def test_it_can_give_proficiency_by_race_or_ethnicity
    data =
    {
     2011 => {math: 0.816, reading: 0.897, writing: 0.826},
     2012 => {math: 0.818, reading: 0.893, writing: 0.808},
    }
    assert_equal data, @st.proficient_by_race_or_ethnicity(:asian)
  end

  def test_it_raises_an_error_if_race_unknown
    assert_raises(UnknownRaceError) do
      @st.proficient_by_race_or_ethnicity(:something)
    end
  end

  #deal with edge cases; no data provided so some lines
  #but probably in statewide test repo class

  def test_it_can_find_proficiency_percent_for_subject_grade_year
    assert_equal 0.857,
    @st.proficient_for_subject_by_grade_in_year(:math, 3, 2008)
  end

  def test_it_raises_error_if_any_parameters_are_invalid
    assert_raises(UnknownDataError) do
      @st.proficient_for_subject_by_grade_in_year(:math, 5, 2008)
    end
    assert_raises(UnknownDataError) do
      @st.proficient_for_subject_by_grade_in_year(:astrology, 3, 2008)
    end
    assert_raises(UnknownDataError) do
      @st.proficient_for_subject_by_grade_in_year(:math, 3, 1910)
    end
  end

  def method_name

  end
end
