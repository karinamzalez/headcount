require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/statewide_testing_formatter'
require_relative '../lib/parser_subject_proficiency'
require 'csv'

class StatewideTestingFormatterTest < Minitest::Test
  include StatewideTestingFormatter
  include ParserSubjectProficiency

  def setup
    @data =
    {
      :statewide_testing =>
      {
        :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
        :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
        :math => "./test/data/test_prof_math_short.csv",
        :reading => "./test/data/test_prof_reading_short.csv",
        :writing => "./test/data/test_prof_writing_short.csv"
      }
    }
  end

  def test_it_can_find_the_math_file
    assert_equal './test/data/test_prof_math_short.csv', math_file(@data)
  end

  def test_it_can_find_the_reading_file
    assert_equal './test/data/test_prof_reading_short.csv', reading_file(@data)
  end

  def test_it_can_find_the_writing_file
    assert_equal './test/data/test_prof_writing_short.csv', writing_file(@data)
  end

  def test_it_can_get_formatted_hashes_for_each_subject
    output  =
      [
        {
          :name=>"ADAMS COUNTY 14",
          :all_students=>
          {
            "2011"=>{:math=>"0.32"}, "2012"=>{:math=>"0.28737"}
          },
          :asian=>
          {
            "2011"=>{:math=>"N/A"}
          },
          :black=>
          {
            "2011"=>{:math=>"0.1961"}
          }
        },
        {
          :name=>"ADAMS-ARAPAHOE 28J",
          :all_students=>
          {
            "2011"=>{:math=>"0.38"}, "2012"=>{:math=>"0.37735"}
          },
          :asian=>
          {
            "2011"=>{:math=>"0.4817"}
          },
          :black=>
          {
            "2011"=>{:math=>"0.291"}
          }
        },
        {
          :name=>"ADAMS COUNTY 14",
          :all_students=>
          {
            "2011"=>{:reading=>"0.44"}, "2012"=>{:reading=>"0.42674"}},
          :asian=>
          {
            "2011"=>{:reading=>"LNE"}
          },
          :black=>
          {
            "2011"=>{:reading=>"0.3333"}
          }
        },
        {
          :name=>"ADAMS-ARAPAHOE 28J",
          :all_students=>
          {
            "2011"=>{:reading=>"0.47"}, "2012"=>{:reading=>"0.48299"}
          },
          :asian=>
          {
            "2011"=>{:reading=>"0.5089"}
          },
          :black=>
          {
            "2011"=>{:reading=>"0.4135"}
          }
        },
        {
        :name=>"ADAMS COUNTY 14",
        :all_students=>
          {
            "2011"=>{:writing=>"0.3172"}, "2012"=>{:writing=>"0.27973"}
          },
        :asian=>
          {
            "2011"=>{:writing=>"LNE"}
          },
        :black=>
          {
            "2011"=>{:writing=>"0.2255"}
          }
        },
        {
          :name=>"ADAMS-ARAPAHOE 28J",
          :all_students=>
          {
            "2011"=>{:writing=>"0.3429"}, "2012"=>{:writing=>"0.35533"}
          },
          :asian=>
          {
            "2011"=>{:writing=>"0.4379"}},
          :black=>
          {
            "2011"=>{:writing=>"0.3013"}}
        }
      ]

    assert_equal output, get_final_formatted_hashes_per_subject(@data)

  end

  def test_it_can_return_formatted_hashes_per_district_per_race
    output =
    [
      {:name=>"ADAMS COUNTY 14",
        :all_students=>
        {
          "2011"=>{:math=>"0.32", :reading=>"0.44", :writing=>"0.3172"},
         "2012"=>{:math=>"0.28737", :reading=>"0.42674", :writing=>"0.27973"}
        },
        :asian=>
        {
          "2011"=>{:math=>"N/A", :reading=>"LNE", :writing=>"LNE"}
        },
        :black=>
        {
          "2011"=>{:math=>"0.1961", :reading=>"0.3333", :writing=>"0.2255"}
        }
      },
      {:name=>"ADAMS-ARAPAHOE 28J",
        :all_students=>
        {
          "2011"=>{:math=>"0.38", :reading=>"0.47", :writing=>"0.3429"},
          "2012"=>{:math=>"0.37735", :reading=>"0.48299", :writing=>"0.35533"}
        },
        :asian=>
        {
          "2011"=>{:math=>"0.4817", :reading=>"0.5089", :writing=>"0.4379"}
        },
        :black=>
        {
          "2011"=>{:math=>"0.291", :reading=>"0.4135", :writing=>"0.3013"}
        }
      }
    ]
    assert_equal output, formatted_hashes_per_district_2(@data)
  end

end
