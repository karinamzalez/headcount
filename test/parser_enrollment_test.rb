require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/parser_enrollment'
require_relative '../lib/simplify_parsers_module'
require 'csv'

class ParserTest < Minitest::Test
include ParserEnrollment
include SimplifyParsers

  def test_it_can_format_each_line_into_a_hash
    data =
      [
        {
          :name=>"Colorado",
          :kindergarten_participation=>{2007=>0.394}
        },
        {
          :name=>"Colorado",
          :kindergarten_participation=>{2006=>0.336}
        },
        {
          :name=>"ACADEMY 20",
          :kindergarten_participation=>{2007=>0.391}
        },
        {
          :name=>"ACADEMY 20",
          :kindergarten_participation=>{2006=>0.353}
        },
        {
          :name=>"ADAMS COUNTY 14",
          :kindergarten_participation=>{2007=>0.306}
        },
        {
          :name=>"ADAMS COUNTY 14",
          :kindergarten_participation=>{2006=>0.293}
        }
      ]
      assert_equal data, format_hash_per_line('./test/data/parser_kinder_data.csv', "kindergarten_participation")
  end
  
end
