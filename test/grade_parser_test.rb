require 'simplecov'
SimpleCov.start

gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/grade_parser'
require 'csv'

class ParserGradeTest < Minitest::Test
include ParserGrade

  def test_it_can_get_the_raw_data_from_a_csv
    data =
    [
      {
        :location=>"Colorado", :score=>"Math", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.697"
      },
      {
        :location=>"Colorado", :score=>"Reading", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.703"
      },
      {
        :location=>"Colorado", :score=>"Writing", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.501"
      },
      {
        :location=>"ACADEMY 20", :score=>"Math", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.857"
      },
      {
        :location=>"ACADEMY 20", :score=>"Reading", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.866"
      },
      {
        :location=>"ACADEMY 20", :score=>"Writing", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.671"
      },
      {
        :location=>"ADAMS COUNTY 14", :score=>"Math", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.56"
      },
      {
        :location=>"ADAMS COUNTY 14", :score=>"Reading", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.523"
      },
      {
        :location=>"ADAMS COUNTY 14", :score=>"Writing", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.426"
      }
    ]

    assert_equal data, get_raw_data('./test/data/3rd_grade.csv')
  end

  def test_it_can_delete_unneeded_columns
    data =
    [
      {
        :location=>"Colorado", :score=>"Math", :timeframe=>"2008", :data=>"0.697"
      },
      {
        :location=>"Colorado", :score=>"Reading", :timeframe=>"2008", :data=>"0.703"
      },
      {
        :location=>"Colorado", :score=>"Writing", :timeframe=>"2008", :data=>"0.501"
      },
      {
        :location=>"ACADEMY 20", :score=>"Math", :timeframe=>"2008", :data=>"0.857"
      },
      {
        :location=>"ACADEMY 20", :score=>"Reading", :timeframe=>"2008", :data=>"0.866"
      },
      {
        :location=>"ACADEMY 20", :score=>"Writing", :timeframe=>"2008", :data=>"0.671"
      },
      {
        :location=>"ADAMS COUNTY 14", :score=>"Math", :timeframe=>"2008", :data=>"0.56"
      },
      {
        :location=>"ADAMS COUNTY 14", :score=>"Reading", :timeframe=>"2008", :data=>"0.523"
      },
      {
        :location=>"ADAMS COUNTY 14", :score=>"Writing", :timeframe=>"2008", :data=>"0.426"
      }
    ]

    assert_equal data, delete_dataformat('./test/data/3rd_grade.csv')
  end

  def test_it_can_format_each_line_into_a_hash
    data =
    [
      {
        :name=>"Colorado", :third_grade_proficiency=>{"2008"=>{"Math"=>"0.697"}}
      },
      {
        :name=>"Colorado", :third_grade_proficiency=>{"2008"=>{"Reading"=>"0.703"}}
      },
      {
        :name=>"Colorado", :third_grade_proficiency=>{"2008"=>{"Writing"=>"0.501"}}
      },
      {
        :name=>"ACADEMY 20", :third_grade_proficiency=>{"2008"=>{"Math"=>"0.857"}}
      },
      {
        :name=>"ACADEMY 20", :third_grade_proficiency=>{"2008"=>{"Reading"=>"0.866"}}
      },
      {
        :name=>"ACADEMY 20", :third_grade_proficiency=>{"2008"=>{"Writing"=>"0.671"}}
      },
      {
        :name=>"ADAMS COUNTY 14", :third_grade_proficiency=>{"2008"=>{"Math"=>"0.56"}}
      },
      {
        :name=>"ADAMS COUNTY 14", :third_grade_proficiency=>{"2008"=>{"Reading"=>"0.523"}}
      },
      {
        :name=>"ADAMS COUNTY 14", :third_grade_proficiency=>{"2008"=>{"Writing"=>"0.426"}}
      }
    ]
    assert_equal data, format_hash_per_line('./test/data/3rd_grade.csv', "third_grade_proficiency")
  end

  def test_it_can_group_lines_by_district_name
    data =
    {
      "Colorado"=>
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
      ],
     "ACADEMY 20"=>
     [
       {
         :name=>"ACADEMY 20", :third_grade_proficiency=>{"2008"=>{"Math"=>"0.857"}}
        },
        {
          :name=>"ACADEMY 20", :third_grade_proficiency=>{"2008"=>{"Reading"=>"0.866"}}
        },
        {
          :name=>"ACADEMY 20", :third_grade_proficiency=>{"2008"=>{"Writing"=>"0.671"}}
        }
      ],
     "ADAMS COUNTY 14"=>
     [
       {
         :name=>"ADAMS COUNTY 14", :third_grade_proficiency=>{"2008"=>{"Math"=>"0.56"}}
        },
        {
          :name=>"ADAMS COUNTY 14", :third_grade_proficiency=>{"2008"=>{"Reading"=>"0.523"}}
        },
        {
          :name=>"ADAMS COUNTY 14", :third_grade_proficiency=>{"2008"=>{"Writing"=>"0.426"}}
        }
      ]
    }
    assert_equal data, group_by_name('./test/data/3rd_grade.csv', "third_grade_proficiency")
  end

end
