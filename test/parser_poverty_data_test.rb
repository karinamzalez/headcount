require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/parser_poverty_data'
require_relative '../lib/simplify_parsers_module'

class ParserPovertyDataTest < Minitest::Test
  include ParserPovertyData
  include SimplifyParsers

  def test_it_format_poverty_lines_to_hashes
    data =
    [
      {
        :name=>"ACADEMY 20", :children_in_poverty=>{2007=>0.039}
      },
      {
        :name=>"ACADEMY 20", :children_in_poverty=>{2008=>0.04404}
      },
      {
        :name=>"ADAMS COUNTY 14", :children_in_poverty=>{2007=>0.247}
      },
      {
        :name=>"ADAMS COUNTY 14", :children_in_poverty=>{2008=>0.22533}
      },
      {
        :name=>"ADAMS-ARAPAHOE 28J", :children_in_poverty=>{2007=>0.238}
      },
      {
        :name=>"ADAMS-ARAPAHOE 28J", :children_in_poverty=>{2008=>0.18582}
      }
    ]
    assert_equal data,
    format_poverty_hash_per_line('./test/data/poverty.csv', "children_in_poverty")
  end

end
