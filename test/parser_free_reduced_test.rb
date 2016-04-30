require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/parser_free_reduced'
require_relative '../lib/simplify_parsers_module'
require 'csv'

class ParserFreeReducedTest < Minitest::Test
  include ParserFreeReduced
  include SimplifyParsers

  def test_it_can_format_each_free_reduced_line_into_hash
    output =
      [
        {
          :name=>"Colorado",
          :free_or_reduced_price_lunch=>{2012=>{:number=>297167}}
        },
        {
          :name=>"Colorado",
          :free_or_reduced_price_lunch=>{2012=>{:percent=>0.344}}
        },
        {
          :name=>"Colorado",
          :free_or_reduced_price_lunch=>{2014=>{:percent=>0.34346}}
        },
        {
          :name=>"Colorado",
          :free_or_reduced_price_lunch=>{2014=>{:number=>305342}}
        },
        {
          :name=>"ACADEMY 20",
          :free_or_reduced_price_lunch=>{2014=>{:number=>2156}}
        },
        {
          :name=>"ACADEMY 20",
          :free_or_reduced_price_lunch=>{2014=>{:percent=>0.08772}}
        },
        {
          :name=>"ACADEMY 20",
          :free_or_reduced_price_lunch=>{2012=>{:percent=>0.09027}}
        },
        {
          :name=>"ACADEMY 20",
          :free_or_reduced_price_lunch=>{2012=>{:number=>2164}}
        },
        {
          :name=>"ADAMS COUNTY 14",
          :free_or_reduced_price_lunch=>{2012=>{:number=>5486}}
        },
        {
          :name=>"ADAMS COUNTY 14",
          :free_or_reduced_price_lunch=>{2012=>{:percent=>0.73147}}
        },
        {
          :name=>"ADAMS COUNTY 14",
          :free_or_reduced_price_lunch=>{2014=>{:percent=>0.65322}}
        },
        {
          :name=>"ADAMS COUNTY 14",
          :free_or_reduced_price_lunch=>{2014=>{:number=>4954}}
        }
      ]
    assert_equal output, format_free_reduced_hash_per_line('./test/data/lunch.csv', "free_or_reduced_price_lunch")
  end

end
