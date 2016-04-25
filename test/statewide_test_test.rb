gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/statewide_test'

class StatewideTestTest < Minitest::Test

  def setup
    @st = StatewideTest.new(
    {
      :name => "ACADEMY 20",
      :third_grade =>
      {
       2008 => {:math => 0.857, :reading => 0.866, :writing => 0.671},
       2009 => {:math => 0.824, :reading => 0.862, :writing => 0.706}
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

  # def test_it_raises_an_error_if_grade_unknown
  #   assert_equal "UnknownDataError", @st.proficient_by_grade(5)
  #   # assert_raises(UnknownDataError) do require "pry"; binding.pry
  #   #   @st.proficient_by_grade(5)
  #   # end
  # end

  def test_it_can_give_proficiency

  end
end
