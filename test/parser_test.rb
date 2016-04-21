gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/parser'

class ParserTest < Minitest::Test

  # def initialize
  #   @p = Parser.new
  # end

  def test_it_can_get_the_raw_data_from_a_csv
    data = [{location: "Colorado", timeframe: "2007", datatype: "Percent", data: "0.39465"},
      {location: "Colorado", timeframe: "2006", datatype: "Percent", data: "0.33677"},
      {location: "ACADEMY 20", timeframe: "2007", datatype: "Percent", data: "0.39159"},
      {location: "ACADEMY 20", timeframe: "2006", datatype: "Percent", data: "0.35364"},
      {location: "ADAMS COUNTY 14", timeframe: "2007", datatype: "Percent", data: "0.30643"},
      {location: "ADAMS COUNTY 14", timeframe: "2006", datatype: "Percent", data: "0.29331"}]

    assert_equal data, Parser.get_raw_data('./test/data/parser_data.csv')
  end

  def test_it_can_delete_unneeded_columns
  end

  def test_it_can_format_each_line_into_a_hash
    skip
    data = [{name: "Colorado", kindergarten_participation: {"2007" => "0.39465"}},
      {name: "Colorado", kindergarten_participation: {"2006" => "0.33677"}},
      {name: "ACADEMY 20", kindergarten_participation: {"2007" => "0.39159"}},
      {name: "ACADEMY 20", kindergarten_participation: {"2006" => "0.35364"}},
      {name: "ADAMS COUNTY 14", kindergarten_participation: {"2007" => "0.30643"}},
      {name: "ADAMS COUNTY 14", kindergarten_participation: {"2006" => "0.29331"}}]
  end

  def test_it_can_group_lines_by_district_name
    skip
  end

end
