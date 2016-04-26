require 'simplecov'
SimpleCov.start

gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/parser_subject_proficiency'
require_relative '../test/parser_outputs_module'
require 'csv'

class ParserGradeTest < Minitest::Test
include ParserSubjectProficiency
include ParserOutputs

  def test_it_can_get_the_raw_subject_data_from_a_csv
    assert_equal get_raw_data_output, get_the_raw_data('./test/data/test_prof_math.csv')
  end

  def test_it_can_delete_dataformat
    assert_equal delete_dataformat_output, delete_dataformat_only('./test/data/test_prof_math.csv')
  end

  def test_it_can_format_each_subject_line_into_a_hash
    assert_equal format_subject_hash_per_line_output, format_subject_hash_per_line('./test/data/test_prof_math.csv', "math")
  end

  def test_it_can_group_subject_lines_by_district_name
    assert_equal group_by_district_name_output, group_by_district_name('./test/data/test_prof_math.csv', "math")
  end
  
  def test_it_deep_merges_two_name_race_hashes
    h1 = {name: "Colorado", asian: {2011 => {"math" => 0}}}
    h2 = {name: "Colorado", black: {2012 => {"math" => 0}}}

    computed = deep_merge(h1,h2)
    expected = {name: "Colorado", asian: {2011 => {"math" => 0}}, black: {2012 => {"math" => 0}}}
    assert_equal expected, computed

    h3 = {name: "Colorado", asian: {2011 => {"math" => 0}}}
    h4 = {name: "Colorado", asian: {2012 => {"math" => 0}}}

    computed = deep_merge(h3,h4)
    expected = {name: "Colorado", asian: {2011 => {"math" => 0}, 2012 => {"math" => 0}}}
    assert_equal expected, computed
  end

  def test_it_deep_merges_a_name_race_hash_with_name_race_composite_hash
    h1 = {name: "Colorado", asian: {2011 => {"math" => 0}, 2012 => {"math" => 0}}}
    h2 = {name: "Colorado", black: {2012 => {"math" => 0}}}

    computed = deep_merge(h1,h2)
    expected = {name: "Colorado", asian: {2011 => {"math" => 0}, 2012 => {"math" => 0}}, black: {2012 => {"math" => 0}}}
    assert_equal expected, computed

    h3 = {name: "Colorado", asian: {2013 => {"math" => 0}}}

    computed = deep_merge(h1,h3)
    expected = {name: "Colorado", asian: {2011 => {"math" => 0}, 2012 => {"math" => 0}, 2013 => {"math" => 0}}}
    assert_equal expected, computed
  end

  def test_it_iteratively_does_the_do
  input = [{:name=>"Colorado", :all_students=>{"2011"=>{"math"=>"0.5573"}}},
   {:name=>"Colorado", :asian=>{"2011"=>{"math"=>"0.7094"}}},
   {:name=>"Colorado", :black=>{"2011"=>{"math"=>"0.3333"}}},
   {:name=>"Colorado", :all_students=>{"2012"=>{"math"=>"0.558"}}}]
  output = {:name=>"Colorado", :all_students=>{"2011"=>{"math"=>"0.5573"}, "2012"=>{"math"=>"0.558"}}, :asian=>{"2011"=>{"math"=>"0.7094"}}, :black=>{"2011"=>{"math"=>"0.3333"}}}

    assert_equal output, iteratively_apply_deep_merge(input)
  end

  def test_it_can_return_formatted_hashes_per_district
    output =
    [
     {
       :name=>"ADAMS COUNTY 14",
       :all_students=>{"2011"=>{"math"=>"0.32"}, "2012"=>{"math"=>"0.28737"}},
       :asian=>{"2011"=>{"math"=>"N/A"}},
       :black=>{"2011"=>{"math"=>"0.1961"}}
     },
     {
       :name=>"ADAMS-ARAPAHOE 28J",
       :all_students=>{"2011"=>{"math"=>"0.38"}, "2012"=>{"math"=>"0.37735"}},
       :asian=>{"2011"=>{"math"=>"0.4817"}},
       :black=>{"2011"=>{"math"=>"0.291"}}
     }
    ]

    assert_equal output, formatted_hashes_per_district('./test/data/test_prof_math_short.csv', "math")
  end
end
