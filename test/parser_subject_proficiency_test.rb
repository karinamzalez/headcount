require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/parser_subject_proficiency'
require_relative '../lib/simplify_parsers_module'
require_relative '../test/data/parser_outputs_module'
require 'csv'

class ParserGradeTest < Minitest::Test
include ParserSubjectProficiency
include ParserOutputs
include SimplifyParsers

  def test_it_can_format_each_subject_line_into_a_hash
    assert_equal format_subject_hash_per_line_output, format_subject_hash_per_line('./test/data/test_prof_math.csv', "math")
  end

  def test_it_deep_merges_two_name_race_hashes
    h1 = {name: "Colorado", asian: {2011 => {:math => 0}}}
    h2 = {name: "Colorado", black: {2012 => {:math => 0}}}

    computed = deep_merge(h1,h2)
    expected = {name: "Colorado", asian: {2011 => {:math => 0}}, black: {2012 => {:math => 0}}}
    assert_equal expected, computed

    h3 = {name: "Colorado", asian: {2011 => {:math => 0}}}
    h4 = {name: "Colorado", asian: {2012 => {:math => 0}}}

    computed = deep_merge(h3,h4)
    expected = {name: "Colorado", asian: {2011 => {:math => 0}, 2012 => {:math => 0}}}
    assert_equal expected, computed
  end

  def test_it_deep_merges_a_name_race_hash_with_name_race_composite_hash
    h1 = {name: "Colorado", asian: {2011 => {:math => 0}, 2012 => {:math => 0}}}
    h2 = {name: "Colorado", black: {2012 => {:math => 0}}}

    computed = deep_merge(h1,h2)
    expected = {name: "Colorado", asian: {2011 => {:math => 0}, 2012 => {:math => 0}}, black: {2012 => {:math => 0}}}
    assert_equal expected, computed

    h3 = {name: "Colorado", asian: {2013 => {:math => 0}}}

    computed = deep_merge(h1,h3)
    expected = {name: "Colorado", asian: {2011 => {:math => 0}, 2012 => {:math => 0}, 2013 => {:math => 0}}}
    assert_equal expected, computed
  end

  def test_it_iteratively_does_the_do
    input =
      [
        {
          :name=>"Colorado", :all_students=>{"2011"=>{"math"=>"0.5573"}}
        },
       {
         :name=>"Colorado", :asian=>{"2011"=>{"math"=>"0.7094"}}
       },
       {
         :name=>"Colorado", :black=>{"2011"=>{"math"=>"0.3333"}}
       },
       {
         :name=>"Colorado", :all_students=>{"2012"=>{"math"=>"0.558"}}
       }
      ]
    output =
      {
        :name=>"Colorado",
        :all_students=>{"2011"=>{"math"=>"0.5573"}, "2012"=>{"math"=>"0.558"}},
        :asian=>{"2011"=>{"math"=>"0.7094"}},
        :black=>{"2011"=>{"math"=>"0.3333"}}
      }
    assert_equal output, iteratively_apply_deep_merge(input)
  end

end
