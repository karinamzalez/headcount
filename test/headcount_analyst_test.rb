require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/headcount_analyst'
require_relative '../lib/district_repository'

class HeadcountAnalystTest < Minitest::Test

  def setup
    @dr = DistrictRepository.new
    @dr.load_data({
      :enrollment => {
        :kindergarten => "./test/data/kindergarten.csv"
      }
      })
    @ha = HeadcountAnalyst.new(@dr)
  end

  def test_it_can_find_average_enrollment_for_a_district
    assert_equal 0.337, @ha.average_enrollment("ACADEMY 20")
  end

  def test_it_can_find_kindergarten_participation_rate_variation
    assert_equal 1.002, @ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'COLORADO')
    assert_equal 1.124, @ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'ADAMS COUNTY 14')
  end

  def test_it_can_find_variation_trends
    hash = {2007 => 0.992, 2006 => 1.050, 2005 => 0.960}
    assert_equal hash, @ha.kindergarten_participation_rate_variation_trend('ACADEMY 20', :against => 'COLORADO')
  end

end
