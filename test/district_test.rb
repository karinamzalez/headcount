require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/district'
require_relative '../lib/statewide_test'
require_relative '../lib/enrollment'

class DistrictTest < Minitest::Test

  def setup
    @d = District.new({:name => "ACADEMY 20"})
  end

  def test_it_exists
    d = District.new({:name => "potato"})
    assert_equal District, d.class
  end

  def test_it_receives_argument
    assert_equal "ACADEMY 20", @d.name
  end

  def test_it_is_case_insensitive
    assert_equal "ACADEMY 20", @d.name
  end

end
