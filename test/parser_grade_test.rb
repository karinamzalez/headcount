require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/parser_grade'
require_relative '../test/data/parser_outputs_module'
require_relative '../lib/simplify_parsers_module'
require 'csv'

class ParserGradeTest < Minitest::Test
  include ParserGrade
  include SimplifyParsers
  include ParserOutputs

  def test_it_can_format_each_line_into_a_hash
    assert_equal grade_format_each_line_output, format_grade_hash_per_line('./test/data/3rd_grade.csv', "third_grade_proficiency")
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
    output =
    {
      :name=>"Colorado", :third_grade_proficiency=>
      {
        "2008"=>
        {"Math"=>"0.697", "Reading"=>"0.703", "Writing"=>"0.501"}
      }
    }
    assert_equal output, iteratively_apply_deep_merge_levels(input)
  end

end
