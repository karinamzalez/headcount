require 'simplecov'
SimpleCov.start

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
      :asian =>
      {
       2011 => {math: 0.816, reading: 0.897, writing: 0.826},
       2012 => {math: 0.818, reading: 0.893, writing: 0.808}
     },
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
    assert_raises(UnknownDataError) do
      @st.proficient_by_race_or_ethnicity(:something)
    end
  end
  
  def test_it_can_find_proficiency_percent_for_subject_grade_year
    assert_equal 0.857,
    @st.proficient_for_subject_by_grade_in_year(:math, 3, 2008)
  end

  def test_it_raises_error_if_subject_is_invalid_for_grade_method
    assert_raises(UnknownDataError) do
      @st.proficient_for_subject_by_grade_in_year(:astrology, 3, 2008)
    end
  end

  def test_it_raises_error_if_grade_is_invalid_for_grade_method
    assert_raises(UnknownDataError) do
      @st.proficient_for_subject_by_grade_in_year(:math, 5, 2008)
    end
  end

  def test_it_raises_error_if_year_is_invalid_for_grade_method
    assert_raises(UnknownDataError) do
      @st.proficient_for_subject_by_grade_in_year(:math, 3, 1910)
    end
  end

  def test_it_can_find_proficiency_for_subject_race_year
    assert_equal 0.818,
    @st.proficient_for_subject_by_race_in_year(:math, :asian, 2012)
  end

  def test_it_raises_error_if_race_is_invalid_for_race_method
    assert_raises(UnknownDataError) do
      @st.proficient_for_subject_by_race_in_year(:math, :guy, 2012)
    end
  end

  def test_it_raises_error_if_subject_is_invalid_for_race_method
    assert_raises(UnknownDataError) do
      @st.proficient_for_subject_by_race_in_year(:astrology, :asian, 2012)
    end
  end

  def test_it_raises_error_if_year_is_invalid_for_race_method
    assert_raises(UnknownDataError) do
      @st.proficient_for_subject_by_race_in_year(:math, :asian, 1910)
    end
  end

end
