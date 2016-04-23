require 'simplecov'
SimpleCov.start

gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/enrollment'

class EnrollmentTest < Minitest::Test
  #test_it_is_case_insensitive
  #test_it_truncates_data_upon_initialize
  #edge case: decimals that end in zero are getting end zero cut off

  def setup
    @enrollment = Enrollment.new (
    { :name => "ACADEMY 20", :kindergarten_participation =>
      {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677} }
    )
    @enrollment2 = Enrollment.new (
    { :name => "ACADEMY 20", :kindergarten_participation =>
      {"2010" => "0.3915", "2011" => "0.35356", "2012" => "0.2677"} }
    )
  end

  def test_it_truncates_percents
    assert_equal({"pizza" => 0.123}, @enrollment.truncate_percents({"pizza" => 0.1234}))
  end

  def test_it_can_give_kindergarten_participation_by_year
    data = { 2010 => 0.391,
      2011 => 0.353,
      2012 => 0.267 }
    assert_equal data, @enrollment.kindergarten_participation_by_year
  end

  def test_it_can_give_kindergarten_participation_for_a_given_year
    assert_equal 0.391, @enrollment.kindergarten_participation_in_year(2010)
  end

  def test_it_can_take_in_year_as_string
    assert_equal 0.391, @enrollment2.kindergarten_participation_in_year("2010")
  end

  def test_it_can_return_nil_if_no_year_exists
    assert_equal nil, @enrollment.kindergarten_participation_in_year(2008)
  end

  def test_it_can_find_graduation_rates_by_year

  end

  def test_it_can_find_graduation_rates_in_a_given_year

  end


  #edge cases: case insensitive?
  #numbers come in as strings intead of ints?
end
