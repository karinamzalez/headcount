require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/district_repository'
require 'csv'

class DistrictRepositoryTest < Minitest::Test
  def setup
    @dr = DistrictRepository.new
    @data_full =
    {
      :enrollment =>
        {
          :kindergarten => "./test/data/kindergarten.csv",
          :high_school_graduation => "./test/data/parser_high_school_data.csv"
        },
      :statewide_testing =>
        {
          :third_grade=> "./test/data/3rd_grade.csv",
          :eighth_grade=> "./test/data/8th_grade.csv",
          :math => "./test/data/test_prof_math.csv",
          :reading => "./test/data/test_proficiency_reading.csv",
          :writing => "./test/data/test_proficiency_writing.csv"
        }
    }
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

  def test_it_can_take_in_data_from_a_csv
    @dr.load_data(
    {
      :enrollment =>
      {
        :kindergarten => "./test/data/kindergarten.csv",
        :high_school_graduation => "./test/data/parser_high_school_data.csv"
      }
    })
    assert_equal 4, @dr.districts.count
  end

  def test_it_makes_enrollnment_repo_w_enrollment_objects
    @dr.load_data(
    {
      :enrollment =>
      {
        :kindergarten => "./test/data/kindergarten.csv"
      }
    })
    assert_equal EnrollmentRepository, @dr.enrollment_repo.class
    assert_equal Enrollment, @dr.enrollment_repo.enrollments.first.class
  end

  def test_it_accesses_array_of_enrollment_objects
    @dr.load_data(
    {
      :enrollment =>
      {
        :kindergarten => "./test/data/kindergarten.csv"
      }
    })
      assert_equal Enrollment, @dr.access_enrollments[0].class
  end

  def test_it_can_find_enrollment_data_for_a_given_year
    @dr.load_data(
    {
      :enrollment =>
      {
        :kindergarten => "./test/data/kindergarten.csv"
      }
    })
      district = @dr.find_by_name("ACADEMY 20")
      assert_equal 0.267, district.enrollment.kindergarten_participation_in_year(2005)
  end

  def test_it_can_make_districts_by_name
      grouped_district_data =
      {
        "Colorado"=>
        [
          {
            :name=>"Colorado",
            :kindergarten_participation=> {"2007"=>"0.39465"}
          }
        ]
      }
      @dr.make_districts_by_name(grouped_district_data)
      assert_equal "COLORADO", @dr.districts[0].name
  end

  def test_it_can_find_all_matching_with_name_fragment
    data =
      {
        :enrollment =>
        {
          :kindergarten => "./test/data/kindergarten.csv"
        }
      }
    @dr.load_data(data)
    assert_equal "./test/data/kindergarten.csv", @dr.kindergarten_file(data)
    assert_equal 2, @dr.find_all_matching("ada").count
  end

  def test_it_can_acces_array_of_statewide_test_objects
    @dr.load_data(@data_full)
    assert_equal StatewideTest, @dr.access_statewide_tests[0].class
  end

  def test_it_can_load_enrollments_and_statewide_tests_at_once
    @dr.load_data(@data_full)
    assert_equal StatewideTest, @dr.access_statewide_tests[0].class
    assert_equal Enrollment, @dr.access_enrollments[0].class
  end

  def test_districts_can_access_enrollment_obejcts
    @dr.load_data(@data_full)
    assert_equal Enrollment, @dr.districts[0].enrollment.class
  end

  def test_districts_can_access_statewide_test_objects
    @dr.load_data(@data_full)
    assert_equal StatewideTest, @dr.districts[0].statewide_test.class
  end
end
