require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/parser_grade'
require_relative '../test/data/parser_grade_test_module'
require 'csv'

class ParserGradeTest < Minitest::Test
include ParserGrade
include GradeTestOutputs

  def test_it_can_get_the_raw_data_from_a_csv
    assert_equal grade_raw_data_output, get_raw_data('./test/data/3rd_grade.csv')
  end

  def test_it_can_delete_unneeded_columns
    assert_equal grade_delete_ouput, delete_dataformat('./test/data/3rd_grade.csv')
  end

  def test_it_can_format_each_line_into_a_hash
    assert_equal grade_format_each_line_output, format_hash_per_line('./test/data/3rd_grade.csv', "third_grade_proficiency")
  end

  def test_it_can_group_lines_by_district_name
    assert_equal grade_group_lines_by_district, group_by_name('./test/data/3rd_grade.csv', "third_grade_proficiency")
  end

  def test_it_can_return_one_district_per_proficiency_info
    h1 =
      {
        name: "Colorado", third_grade_proficiency: {2008=>{"Math"=>"0.697"}}
      }
    h2 =
      {
        name: "Colorado", third_grade_proficiency: {2008=>{"Reading"=>"0.703"}}
      }
      expected =
      {
        :name=>"Colorado",
        :third_grade_proficiency=>
        {2008=>{"Math"=>"0.697", "Reading"=>"0.703"}}
      }
      assert_equal expected, deep_merge_levels(h1, h2)
    h1 =
      {
        :name=>"Colorado",
        :third_grade_proficiency=>
        {2008=>{"Math"=>"0.697", "Reading"=>"0.703"}}
      }
    h3 =
    {
      name: "Colorado", third_grade_proficiency: {2008=>{"Writing"=>"0.703"}}
    }
    expected =
      {:name=>"Colorado", :third_grade_proficiency=>{2008=>{"Math"=>"0.697", "Reading"=>"0.703", "Writing"=>"0.703"}}}
    assert_equal expected, deep_merge_levels(h1, h3)
  end

  def test_it_can_return_formatted_hashes_per_district_grade
    output =
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
    assert_equal output, formatted_hashes_per_district_grade('./test/data/3rd_grade.csv', "third_grade_proficiency")
  end

  def test_it_can_iteratively_apply_deep_merge_levels
    input =
    [
      {
        :name=>"Colorado", :third_grade_proficiency=>{"2008"=>{"Math"=>"0.697"}}
      },
     {
       :name=>"Colorado", :third_grade_proficiency=>{"2008"=>{"Reading"=>"0.703"}}
     },
     {
       :name=>"Colorado", :third_grade_proficiency=>{"2008"=>{"Writing"=>"0.501"}}
     }
    ]
    output = {:name=>"Colorado", :third_grade_proficiency=>{"2008"=>{"Math"=>"0.697", "Reading"=>"0.703", "Writing"=>"0.501"}}}
    assert_equal output, iteratively_apply_deep_merge_levels(input)
  end

  def test_it_can_clean_the_data
    assert_equal "N/A", clean_data("N/A")
    assert_equal 0.123, clean_data("0.123")
  end

end
