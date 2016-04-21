require 'simplecov'
SimpleCov.start

gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/parser'
require 'csv'

class ParserTest < Minitest::Test
include Parser

  def test_it_can_get_the_raw_data_from_a_csv

    data =[{:location=>"Colorado", :timeframe=>"2007", :dataformat=>"Percent", :data=>"0.39465"},
          {:location=>"Colorado", :timeframe=>"2006", :dataformat=>"Percent", :data=>"0.33677"},
          {:location=>"ACADEMY 20", :timeframe=>"2007", :dataformat=>"Percent", :data=>"0.39159"},
          {:location=>"ACADEMY 20", :timeframe=>"2006", :dataformat=>"Percent", :data=>"0.35364"},
          {:location=>"ADAMS COUNTY 14", :timeframe=>"2007", :dataformat=>"Percent", :data=>"0.30643"},
          {:location=>"ADAMS COUNTY 14", :timeframe=>"2006", :dataformat=>"Percent", :data=>"0.29331"}]

    assert_equal data, get_raw_data('./test/data/parser_data.csv')
  end

  def test_it_can_delete_unneeded_columns
    data =[{:location=>"Colorado", :timeframe=>"2007", :data=>"0.39465"},
          {:location=>"Colorado", :timeframe=>"2006", :data=>"0.33677"},
          {:location=>"ACADEMY 20", :timeframe=>"2007", :data=>"0.39159"},
          {:location=>"ACADEMY 20", :timeframe=>"2006", :data=>"0.35364"},
          {:location=>"ADAMS COUNTY 14", :timeframe=>"2007", :data=>"0.30643"},
          {:location=>"ADAMS COUNTY 14", :timeframe=>"2006", :data=>"0.29331"}]

      assert_equal data, delete_dataformat('./test/data/parser_data.csv')
  end

  def test_it_can_format_each_line_into_a_hash
    data = [{name: "Colorado", kindergarten_participation: {"2007" => "0.39465"}},
      {name: "Colorado", kindergarten_participation: {"2006" => "0.33677"}},
      {name: "ACADEMY 20", kindergarten_participation: {"2007" => "0.39159"}},
      {name: "ACADEMY 20", kindergarten_participation: {"2006" => "0.35364"}},
      {name: "ADAMS COUNTY 14", kindergarten_participation: {"2007" => "0.30643"}},
      {name: "ADAMS COUNTY 14", kindergarten_participation: {"2006" => "0.29331"}}]

      cleaned_data = delete_dataformat('./test/data/parser_data.csv')

      assert_equal data, format_hash_per_line(cleaned_data)
  end

  def test_it_can_group_lines_by_district_name
    data = {"Colorado"=>[{:name=>"Colorado", :kindergarten_participation=>{"2007"=>"0.39465"}},
                  {:name=>"Colorado", :kindergarten_participation=>{"2006"=>"0.33677"}}],
      "ACADEMY 20"=>[{:name=>"ACADEMY 20", :kindergarten_participation=>{"2007"=>"0.39159"}},
                     {:name=>"ACADEMY 20", :kindergarten_participation=>{"2006"=>"0.35364"}}],
      "ADAMS COUNTY 14"=>[{:name=>"ADAMS COUNTY 14", :kindergarten_participation=>{"2007"=>"0.30643"}},
                          {:name=>"ADAMS COUNTY 14", :kindergarten_participation=>{"2006"=>"0.29331"}}]}


      cleaned_data = delete_dataformat('./test/data/parser_data.csv')
      formatted_data = format_hash_per_line(cleaned_data)

      assert_equal data, group_by_name(formatted_data)
   end

end