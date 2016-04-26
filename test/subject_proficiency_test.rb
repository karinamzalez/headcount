require 'simplecov'
SimpleCov.start

gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/parser_subject_proficiency'
require 'csv'

class ParserGradeTest < Minitest::Test
include ParserSubjectProficiency

  # def test_it_can_get_the_raw_subject_data_from_a_csv
  #   data =
  #   [
  #     {
  #       :location=>"Colorado", :race_ethnicity=>"All Students", :timeframe=>"2011", :dataformat=>"Percent", :data=>"0.5573"
  #     },
  #     {
  #       :location=>"Colorado", :race_ethnicity=>"Asian", :timeframe=>"2011", :dataformat=>"Percent", :data=>"0.7094"
  #     },
  #     {
  #       :location=>"Colorado", :race_ethnicity=>"Black", :timeframe=>"2011", :dataformat=>"Percent", :data=>"0.3333"
  #     },
  #     {
  #       :location=>"ACADEMY 20", :race_ethnicity=>"All Students", :timeframe=>"2011", :dataformat=>"Percent", :data=>"0.68"
  #     },
  #     {
  #       :location=>"ACADEMY 20", :race_ethnicity=>"Asian", :timeframe=>"2011", :dataformat=>"Percent", :data=>"0.8169"
  #     },
  #     {
  #       :location=>"ACADEMY 20", :race_ethnicity=>"Black", :timeframe=>"2011", :dataformat=>"Percent", :data=>"0.4246"
  #     },
  #     {
  #       :location=>"ACADEMY 20", :race_ethnicity=>"White", :timeframe=>"2012", :dataformat=>"Percent", :data=>"0.7135"
  #     },
  #     {
  #       :location=>"ADAMS COUNTY 14", :race_ethnicity=>"All Students", :timeframe=>"2011", :dataformat=>"Percent", :data=>"0.32"
  #     },
  #     {
  #       :location=>"ADAMS COUNTY 14", :race_ethnicity=>"Asian", :timeframe=>"2011", :dataformat=>"Percent", :data=>"N/A"
  #     },
  #     {
  #       :location=>"ADAMS COUNTY 14", :race_ethnicity=>"Black", :timeframe=>"2011", :dataformat=>"Percent", :data=>"0.1961"
  #     },
  #     {
  #       :location=>"ADAMS-ARAPAHOE 28J", :race_ethnicity=>"All Students", :timeframe=>"2011", :dataformat=>"Percent", :data=>"0.38"
  #     },
  #     {
  #       :location=>"ADAMS-ARAPAHOE 28J", :race_ethnicity=>"Asian", :timeframe=>"2011", :dataformat=>"Percent", :data=>"0.4817"
  #     },
  #     {
  #       :location=>"ADAMS-ARAPAHOE 28J", :race_ethnicity=>"Black", :timeframe=>"2011", :dataformat=>"Percent", :data=>"0.291"
  #     }
  #   ]
  #   assert_equal data, get_the_raw_data('./test/data/test_prof_math.csv')
  # end
  #
  # def test_it_can_delete_dataformat
  #   data =
  #   [
  #     {
  #       :location=>"Colorado", :race_ethnicity=>"All Students", :timeframe=>"2011", :data=>"0.5573"
  #     },
  #     {
  #       :location=>"Colorado", :race_ethnicity=>"Asian", :timeframe=>"2011", :data=>"0.7094"
  #     },
  #     {
  #       :location=>"Colorado", :race_ethnicity=>"Black", :timeframe=>"2011", :data=>"0.3333"
  #     },
  #     {
  #       :location=>"ACADEMY 20", :race_ethnicity=>"All Students", :timeframe=>"2011", :data=>"0.68"
  #     },
  #     {
  #       :location=>"ACADEMY 20", :race_ethnicity=>"Asian", :timeframe=>"2011", :data=>"0.8169"
  #     },
  #     {
  #       :location=>"ACADEMY 20", :race_ethnicity=>"Black", :timeframe=>"2011", :data=>"0.4246"
  #     },
  #     {
  #       :location=>"ACADEMY 20", :race_ethnicity=>"White", :timeframe=>"2012", :data=>"0.7135"
  #     },
  #     {
  #       :location=>"ADAMS COUNTY 14", :race_ethnicity=>"All Students", :timeframe=>"2011", :data=>"0.32"
  #     },
  #     {
  #       :location=>"ADAMS COUNTY 14", :race_ethnicity=>"Asian", :timeframe=>"2011", :data=>"N/A"
  #     },
  #     {
  #       :location=>"ADAMS COUNTY 14", :race_ethnicity=>"Black", :timeframe=>"2011", :data=>"0.1961"
  #     },
  #     {
  #       :location=>"ADAMS-ARAPAHOE 28J", :race_ethnicity=>"All Students", :timeframe=>"2011", :data=>"0.38"
  #     },
  #     {
  #       :location=>"ADAMS-ARAPAHOE 28J", :race_ethnicity=>"Asian", :timeframe=>"2011", :data=>"0.4817"
  #     },
  #     {
  #       :location=>"ADAMS-ARAPAHOE 28J", :race_ethnicity=>"Black", :timeframe=>"2011", :data=>"0.291"
  #     }
  #   ]
  #   assert_equal data, delete_dataformat_only('./test/data/test_prof_math.csv')
  # end
  #
  # def test_it_can_format_each_subject_line_into_a_hash
  #   data =
  #   [
  #     {
  #       :name=>"Colorado", :all_students=>{"2011"=>{"math"=>"0.5573"}}
  #     },
  #     {
  #       :name=>"Colorado", :asian=>{"2011"=>{"math"=>"0.7094"}}
  #     },
  #     {
  #       :name=>"Colorado", :black=>{"2011"=>{"math"=>"0.3333"}}
  #     },
  #     {
  #       :name=>"ACADEMY 20", :all_students=>{"2011"=>{"math"=>"0.68"}}
  #     },
  #     {
  #       :name=>"ACADEMY 20", :asian=>{"2011"=>{"math"=>"0.8169"}}
  #     },
  #     {
  #       :name=>"ACADEMY 20", :black=>{"2011"=>{"math"=>"0.4246"}}
  #     },
  #     {
  #       :name=>"ACADEMY 20", :white=>{"2012"=>{"math"=>"0.7135"}}
  #     },
  #     {
  #       :name=>"ADAMS COUNTY 14", :all_students=>{"2011"=>{"math"=>"0.32"}}
  #     },
  #     {
  #       :name=>"ADAMS COUNTY 14", :asian=>{"2011"=>{"math"=>"N/A"}}
  #     },
  #     {
  #       :name=>"ADAMS COUNTY 14", :black=>{"2011"=>{"math"=>"0.1961"}}
  #     },
  #     {
  #       :name=>"ADAMS-ARAPAHOE 28J", :all_students=>{"2011"=>{"math"=>"0.38"}}
  #     },
  #     {
  #       :name=>"ADAMS-ARAPAHOE 28J", :asian=>{"2011"=>{"math"=>"0.4817"}}
  #     },
  #     {
  #       :name=>"ADAMS-ARAPAHOE 28J", :black=>{"2011"=>{"math"=>"0.291"}}
  #     }
  #   ]
  #   assert_equal data, format_subject_hash_per_line('./test/data/test_prof_math.csv', "math")
  # end
  #
  # def test_it_can_group_subject_lines_by_district_name
  #   data =
  #   {
  #     "Colorado"=>
  #     [
  #       {
  #         :name=>"Colorado", :all_students=>{"2011"=>{"math"=>"0.5573"}}
  #       },
  #       {
  #         :name=>"Colorado", :asian=>{"2011"=>{"math"=>"0.7094"}}
  #       },
  #       {
  #         :name=>"Colorado", :black=>{"2011"=>{"math"=>"0.3333"}}
  #       }
  #     ],
  #    "ACADEMY 20"=>
  #    [
  #      {
  #        :name=>"ACADEMY 20", :all_students=>{"2011"=>{"math"=>"0.68"}}
  #       },
  #       {
  #         :name=>"ACADEMY 20", :asian=>{"2011"=>{"math"=>"0.8169"}}
  #       },
  #       {
  #         :name=>"ACADEMY 20", :black=>{"2011"=>{"math"=>"0.4246"}}
  #       },
  #       {
  #         :name=>"ACADEMY 20", :white=>{"2012"=>{"math"=>"0.7135"}}
  #       }
  #     ],
  #    "ADAMS COUNTY 14"=>
  #    [
  #      {
  #        :name=>"ADAMS COUNTY 14", :all_students=>{"2011"=>{"math"=>"0.32"}}
  #       },
  #       {
  #         :name=>"ADAMS COUNTY 14", :asian=>{"2011"=>{"math"=>"N/A"}}
  #       },
  #       {
  #         :name=>"ADAMS COUNTY 14", :black=>{"2011"=>{"math"=>"0.1961"}}
  #       }
  #     ],
  #     "ADAMS-ARAPAHOE 28J"=>
  #     [
  #       {
  #         :name=>"ADAMS-ARAPAHOE 28J", :all_students=>{"2011"=>{"math"=>"0.38"}}
  #       },
  #       {
  #         :name=>"ADAMS-ARAPAHOE 28J", :asian=>{"2011"=>{"math"=>"0.4817"}}
  #       },
  #       {
  #         :name=>"ADAMS-ARAPAHOE 28J", :black=>{"2011"=>{"math"=>"0.291"}}
  #       }
  #     ]
  #   }
  #     assert_equal data, group_by_district_name('./test/data/test_prof_math.csv', "math")
  # end

  def test_it_can_group_by_ethnicity
    assert_equal "", merged_all_students_per_district('./test/data/test_prof_math.csv', "math")
  end

end
