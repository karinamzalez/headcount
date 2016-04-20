require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/district'

class DistrictTest < Minitest::Test

  def test_it_exists
    d = District.new({:name => "potato"})
    assert_equal District, d.class
  end

  def test_it_receives_argument
    d = District.new({:name => "ACADEMY 20"})

    assert_equal "ACADEMY 20", d.name
  end

  def test_it_is_case_insensitive
    d = District.new({:name => "Academy 20"})

    assert_equal "ACADEMY 20", d.name
  end
end
