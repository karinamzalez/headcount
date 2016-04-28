require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/parser_grade'
require_relative '../lib/parser_enrollment'
require_relative '../lib/parser_subject_proficiency'
require_relative '../lib/simplify_parsers_module'
require_relative '../test/data/parser_outputs_module'
require 'csv'

class SimplifyParsersTest < Minitest::Test
  include SimplifyParsers
  include ParserGrade
  include ParserEnrollment
  include ParserSubjectProficiency
  include ParserOutputs

  def test_it_can_get_raw_data_from_csv
    assert_equal grade_raw_data_output,
    get_raw_data('./test/data/3rd_grade.csv')
  end

  def test_it_can_delete_dataformat
    assert_equal grade_delete_ouput,
    delete_dataformat('./test/data/3rd_grade.csv')
  end

    def test_it_can_clean_the_data
      assert_equal "N/A", clean_data("N/A")
      assert_equal 0.123, clean_data("0.123")
    end

    def test_it_can_group_by_district_name_for_each_instance
      assert_equal grade_group_lines_by_district, group_by_district_name('./test/data/3rd_grade.csv', "third_grade_proficiency")
      assert_equal math_subject_group_by_district,  group_by_district_name('./test/data/test_prof_math.csv', "math")
      assert_equal kinder_enrollment_group_by_district, group_by_district_name('./test/data/parser_kinder_data.csv', "kindergarten_participation")
    end

    def test_it_formats_hashes_per_district_for_each_instance
      math_output =
        [
          {
            :name=>"ADAMS COUNTY 14",
            :all_students=>{2011=>{:math=>0.32}, 2012=>{:math=>0.287}},
            :asian=>{2011=>{:math=>0.0}},
            :black=>{2011=>{:math=>0.196}}
          },
          {
            :name=>"ADAMS-ARAPAHOE 28J",
            :all_students=>{2011=>{:math=>0.38}, 2012=>{:math=>0.377}},
            :asian=>{2011=>{:math=>0.481}},
            :black=>{2011=>{:math=>0.291}}
          }
        ]
      assert_equal math_output, formatted_hashes_per_district('./test/data/test_prof_math_short.csv', "math")
      grade_output =
        [
          {
            :name=>"ADAMS COUNTY 14",
            :third_grade_proficiency=>
            {
              2008=>{:math=>0.56, :reading=>0.523, :writing=>0.426},
              2009=>{:math=>0.54, :reading=>0.562, :writing=>0.479}}
            },
          {
            :name=>"ADAMS-ARAPAHOE 28J",
            :third_grade_proficiency=>
            {
              2008=>{:math=>0.473, :reading=>0.466, :writing=>0.339},
              2009=>{:math=>0.456, :reading=>0.483, :writing=>0.359}}
            }
        ]
      assert_equal grade_output, formatted_hashes_per_district('./test/data/3rd_grade.csv', "third_grade_proficiency")
    end

end
