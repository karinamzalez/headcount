require 'simplecov'
SimpleCov.start

gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/enrollment'

class EnrollmentTest < Minitest::Test

  def setup

    @enrollment = Enrollment.new (
    { :name => "ACADEMY 20", :kindergarten_participation =>
      {"2010" => "0.3915", "2011" => "0.35356", "2012" => "0.2677"} }
    )

    @enrollment3 = Enrollment.new (
    {:name => "ACADEMY 20", :high_school_graduation =>
      {"2010" => "0.724", "2011" => "0.739", "2012" => "0.75354"}
    }
    )
  end

  def test_it_truncates_percents
    assert_equal({2011 => 0.123}, @enrollment.truncate_percents({"2011" => 0.1234}))
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
    assert_equal 0.391, @enrollment.kindergarten_participation_in_year("2010")
  end

  def test_it_can_return_nil_if_no_year_exists
    assert_equal nil, @enrollment.kindergarten_participation_in_year(2008)
  end

  def test_it_can_find_graduation_rates_by_year
    data = { 2010 => 0.724,
      2011 => 0.739,
      2012 => 0.753 }
    assert_equal data, @enrollment3.graduation_rate_by_year
  end

  def test_it_can_find_graduation_rates_in_a_given_year
    assert_equal 0.724, @enrollment3.graduation_rate_in_year(2010)
  end

end
