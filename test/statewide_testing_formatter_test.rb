require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/statewide_testing_formatter'
require_relative '../lib/parser_subject_proficiency'
require_relative '../lib/parser_grade'
require 'csv'

class StatewideTestingFormatterTest < Minitest::Test
  include StatewideTestingFormatter
  include ParserSubjectProficiency
  include ParserGrade

  def setup
    @data =
    {
      :statewide_testing =>
      {
        :third_grade => "./test/data/3rd_grade.csv",
        :eighth_grade => "./test/data/8th_grade.csv",
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

  def test_it_can_find_the_thrid_grade_file
    assert_equal './test/data/3rd_grade.csv', third_grade_file(@data)
  end

  def test_it_can_find_the_eighth_grade_file
    assert_equal './test/data/8th_grade.csv', eighth_grade_file(@data)
  end

  def test_it_can_get_formatted_hashes_for_each_grade
    output =
      [
        {
          :name=>"ADAMS COUNTY 14", :third_grade_proficiency=>
          {
            "2008"=>{:math=>"0.56", :reading=>"0.523", :writing=>"0.426"},
            "2009"=>{:math=>"0.54", :reading=>"0.562", :writing=>"0.479"}
          }
        },
        {
          :name=>"ADAMS-ARAPAHOE 28J", :third_grade_proficiency=>
          {
            "2008"=>{:math=>"0.473", :reading=>"0.466", :writing=>"0.339"},
            "2009"=>{:math=>"0.456", :reading=>"0.483", :writing=>"0.359"}
          }
        },
        {
          :name=>"ADAMS COUNTY 14", :eighth_grade_proficiency=>
          {
            "2008"=>{:math=>"0.22", :reading=>"0.426", :writing=>"0.444"}, "2009"=>{:math=>"0.3", :reading=>"0.398", :writing=>"0.471"}
          }
        },
        {
          :name=>"ADAMS-ARAPAHOE 28J", :eighth_grade_proficiency=>
          {
            "2008"=>{:math=>"0.32", :reading=>"0.456", :writing=>"0.265"}, "2009"=>{:math=>"0.338", :reading=>"0.437", :writing=>"0.302"}
          }
        }
      ]

    assert_equal output, get_final_formatted_hashes_per_grade(@data)
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

  def test_it_can_group_grade_data_by_district
    output =
    {
      "ADAMS COUNTY 14"=>
      [
        {
          :name=>"ADAMS COUNTY 14",
          :third_grade_proficiency=>
          {
            "2008"=>{:math=>"0.56", :reading=>"0.523", :writing=>"0.426"},
            "2009"=>{:math=>"0.54", :reading=>"0.562", :writing=>"0.479"}
          }
        },
        {
          :name=>"ADAMS COUNTY 14",
          :eighth_grade_proficiency=>
          {
            "2008"=>{:math=>"0.22", :reading=>"0.426", :writing=>"0.444"},
            "2009"=>{:math=>"0.3", :reading=>"0.398", :writing=>"0.471"}
          }
        }
      ],
      "ADAMS-ARAPAHOE 28J"=>
      [
        {
          :name=>"ADAMS-ARAPAHOE 28J",
          :third_grade_proficiency=>
          {
            "2008"=>{:math=>"0.473", :reading=>"0.466", :writing=>"0.339"},
            "2009"=>{:math=>"0.456", :reading=>"0.483", :writing=>"0.359"}
          }
        },
        {
          :name=>"ADAMS-ARAPAHOE 28J",
          :eighth_grade_proficiency=>
          {
            "2008"=>{:math=>"0.32", :reading=>"0.456", :writing=>"0.265"},
            "2009"=>{:math=>"0.338", :reading=>"0.437", :writing=>"0.302"}
          }
        }
      ]
    }
    assert_equal output, group_grade_data_by_district(@data)
  end

  def test_it_can_merge_grade_data_per_district
    output =
    [
      {
        :name=>"ADAMS COUNTY 14",
        :third_grade_proficiency=>
        {
          "2008"=>{:math=>"0.56", :reading=>"0.523", :writing=>"0.426"},
          "2009"=>{:math=>"0.54", :reading=>"0.562", :writing=>"0.479"}
        },
        :eighth_grade_proficiency=>
        {
          "2008"=>{:math=>"0.22", :reading=>"0.426", :writing=>"0.444"},
          "2009"=>{:math=>"0.3", :reading=>"0.398", :writing=>"0.471"}
        }
      },
      {
        :name=>"ADAMS-ARAPAHOE 28J",
        :third_grade_proficiency=>
        {
          "2008"=>{:math=>"0.473", :reading=>"0.466", :writing=>"0.339"},
          "2009"=>{:math=>"0.456", :reading=>"0.483", :writing=>"0.359"}
        },
        :eighth_grade_proficiency=>
        {
          "2008"=>{:math=>"0.32", :reading=>"0.456", :writing=>"0.265"},
          "2009"=>{:math=>"0.338", :reading=>"0.437", :writing=>"0.302"}
        }
      }
    ]

    assert_equal output, merge_grade_data(@data)
  end

  def test_it_can_merge_to_final_hash_per_district_with_all_data
    output =
    [
      {
        :name=>"ADAMS COUNTY 14",
        :third_grade_proficiency=>{"2008"=>{:math=>"0.56", :reading=>"0.523", :writing=>"0.426"}, "2009"=>{:math=>"0.54", :reading=>"0.562", :writing=>"0.479"}},
        :eighth_grade_proficiency=>{"2008"=>{:math=>"0.22", :reading=>"0.426", :writing=>"0.444"}, "2009"=>{:math=>"0.3", :reading=>"0.398", :writing=>"0.471"}},
        :all_students=>{"2011"=>{:math=>"0.32", :reading=>"0.44", :writing=>"0.3172"}, "2012"=>{:math=>"0.28737", :reading=>"0.42674", :writing=>"0.27973"}},
        :asian=>{"2011"=>{:math=>"N/A", :reading=>"LNE", :writing=>"LNE"}},
        :black=>{"2011"=>{:math=>"0.1961", :reading=>"0.3333", :writing=>"0.2255"}}
      },
      {
        :name=>"ADAMS-ARAPAHOE 28J",
        :third_grade_proficiency=>{"2008"=>{:math=>"0.473", :reading=>"0.466", :writing=>"0.339"}, "2009"=>{:math=>"0.456", :reading=>"0.483", :writing=>"0.359"}},
        :eighth_grade_proficiency=>{"2008"=>{:math=>"0.32", :reading=>"0.456", :writing=>"0.265"}, "2009"=>{:math=>"0.338", :reading=>"0.437", :writing=>"0.302"}},
        :all_students=>{"2011"=>{:math=>"0.38", :reading=>"0.47", :writing=>"0.3429"}, "2012"=>{:math=>"0.37735", :reading=>"0.48299", :writing=>"0.35533"}},
        :asian=>{"2011"=>{:math=>"0.4817", :reading=>"0.5089", :writing=>"0.4379"}},
        :black=>{"2011"=>{:math=>"0.291", :reading=>"0.4135", :writing=>"0.3013"}}
      }
    ]
    assert_equal output, merge_all_data(@data)
  end

end
