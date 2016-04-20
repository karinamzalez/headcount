require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/district_repository'

class DistrictRepositoryTest < Minitest::Test

  def setup
    @dr = DistrictRepository.new
  end

  def test_it_exists
    assert_equal DistrictRepository, @dr.class
  end

  def test_it_can_hold_district_objects
    assert_equal Array, @dr.districts.class
    assert_equal [], @dr.districts
  end

  def test_it_can_create_district_instances
    d = District.new({:name => "ACADEMY 20"})
    @dr.districts = [d]

    assert_equal [d], @dr.districts
  end

  def test_it_can_find_a_district_by_name
    d = District.new({:name => "ACADEMY 20"})
    @dr.districts = [d]

    assert_equal d, @dr.find_by_name("ACADEMY 20")
  end

  def test_it_can_find_all_matching_districts
    d = District.new({:name => "ACADEMY 20"})

    @dr.districts = [d]

  end

  # def test_it_can_take_in_data_from_a_csv
  #   skip
  #   assert_equal , @dr.load_data()#enrollment obj data)
  # end
end
