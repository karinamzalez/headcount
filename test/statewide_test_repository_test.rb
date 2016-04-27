# require 'minitest/autorun'
# require 'minitest/pride'
# require_relative '../lib/statewide_test_repository'
#
# class StatewideTestRepositoryTest < Minitest::Test
#
#   def setup
#     @str = StatewideTestRepository.new
#   end
#
#   def test_a_new_statewide_test_repo_has_no_statewide_tests
#     assert_equal [], @str.statewide_tests
#   end
#
#   def test_it_can_find_a_statewide_test_object_by_name
#     s = StatewideTest.new({:name => "ACADEMY 20"})
#     @str.statewide_tests << s
#     assert_equal "ACADEMY 20", @str.find_by_name("ACADEMY 20").name
#   end
#
#   def test_it_is_case_insensitive
#     s = StatewideTest.new({:name => "ACADEMY 20"})
#     @str.statewide_tests << s
#     assert_equal "ACADEMY 20", @str.find_by_name("Academy 20").name
#   end
#
#   def test_it_returns_nil_if_no_enrollment_object_exists
#     assert_equal nil, @str.find_by_name("hello")
#   end
#
#   def test_it_can_load_data_into_statewide_test_objects
#     @str.load_data(
#     {
#       :statewide_testing =>
#       {
#         :third_grade => "./test/data/3rd_grade_scores.csv",
#         :eighth_grade => "./test/data/8th_grade_scores.csv",
#         :math => "./test/data/test_proficiency_math.csv",
#         :reading => "./test/data/test_proficiency_reading.csv",
#         :writing => "./test/data/test_proficiency_writing.csv"
#       }
#       })
#       assert_equal 5, @str.statewide_tests.count
#
#       test_object = @str.find_by_name("ACADEMY 20")
#       assert_equal 0.857,
#       test_data1.proficient_for_subject_by_grade_in_year(:math, 3, 2008)
#
#     #   assert_equal 0.818 ,
#     #   test_object = proficient_for_subject_by_race_in_year(:math, :asian, 2012)
#     end
#
# end
