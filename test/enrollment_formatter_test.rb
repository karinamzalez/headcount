require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/enrollment_repository_formatter'
require_relative '../lib/parser_enrollment'
require_relative '../lib/simplify_parsers_module'
require_relative '../lib/parser_subject_proficiency'

class EnrollmentFormatterTest < Minitest::Test
  include EnrollmentFormatter
  include ParserEnrollment
  include SimplifyParsers
  include ParserSubjectProficiency

  def setup
    @data1 =
    {
      :enrollment =>
        {
          :kindergarten => "./test/data/kindergarten.csv",
        }
    }
    @data2 =
    {
      :enrollment =>
        {
          :kindergarten => "./test/data/kindergarten.csv",
          :high_school_graduation => "./test/data/parser_high_school_data.csv"
        }
    }
  end

  def test_it_can_find_kindergaten_file
    assert_equal "./test/data/kindergarten.csv", kindergarten_file(@data1)
  end

  def test_it_can_find_graduation_file
    assert_equal "./test/data/parser_high_school_data.csv", graduation_file(@data2)
  end

  def test_it_can_format_hashes_for_kinder_only
    output =
    [
      {
        :name=>"Colorado",
        :kindergarten_participation=>{2007=>0.394, 2006=>0.336, 2005=>0.278}
      },
      {
        :name=>"ACADEMY 20",
        :kindergarten_participation=>{2007=>0.391, 2006=>0.353, 2005=>0.267}
      },
      {
        :name=>"ADAMS COUNTY 14",
        :kindergarten_participation=>{2007=>0.306, 2006=>0.293, 2005=>0.3}
      },
      {
        :name=>"ADAMS-ARAPAHOE 28J",
        :kindergarten_participation=>{2007=>0.473, 2006=>0.37, 2005=>0.201}
      }
    ]
    assert_equal output, formatted_hashes_per_enrollment(@data1)
  end

  def test_it_format_hash_per_enrollment
    output =
    [
      {
        :name=>"Colorado",
        :kindergarten_participation=>{2007=>0.394, 2006=>0.336, 2005=>0.278}
      },
      {
        :name=>"ACADEMY 20",
        :kindergarten_participation=>{2007=>0.391, 2006=>0.353, 2005=>0.267}
      },
      {
        :name=>"ADAMS COUNTY 14",
        :kindergarten_participation=>{2007=>0.306, 2006=>0.293, 2005=>0.3}
      },
      {
        :name=>"ADAMS-ARAPAHOE 28J",
        :kindergarten_participation=>{2007=>0.473, 2006=>0.37, 2005=>0.201}
      },
      {
        :name=>"Colorado",
        :high_school_graduation=>{2010=>0.724, 2011=>0.739}
      },
      {
        :name=>"ACADEMY 20",
        :high_school_graduation=>{2010=>0.895, 2011=>0.895}
      },
      {
        :name=>"ADAMS COUNTY 14",
        :high_school_graduation=>{2010=>0.57, 2011=>0.608}
      },
      {
        :name=>"ADAMS-ARAPAHOE 28J",
        :high_school_graduation=>{2010=>0.455, 2011=>0.485}
      }
    ]
    assert_equal output, formatted_hashes_per_enrollment(@data2)
  end

  def test_it_can_gouup_enrollments_by_district_name
    output =
    {
      "Colorado"=>
      [
        {
          :name=>"Colorado",
          :kindergarten_participation=>{2007=>0.394, 2006=>0.336, 2005=>0.278}
        }
      ],
      "ACADEMY 20"=>
      [
        {
          :name=>"ACADEMY 20", :kindergarten_participation=>{2007=>0.391, 2006=>0.353, 2005=>0.267}
        }
      ],
      "ADAMS COUNTY 14"=>
      [
        {
          :name=>"ADAMS COUNTY 14", :kindergarten_participation=>{2007=>0.306, 2006=>0.293, 2005=>0.3}
        }
      ],
      "ADAMS-ARAPAHOE 28J"=>
      [
        {
          :name=>"ADAMS-ARAPAHOE 28J", :kindergarten_participation=>{2007=>0.473, 2006=>0.37, 2005=>0.201}
        }
      ]
    }
    assert_equal output, group_by_district_name_enrollment(@data1)
  end

  def test_it_can_format_final_hashes
    output =
    [
      {
        :name=>"Colorado", :kindergarten_participation=>{2007=>0.394, 2006=>0.336, 2005=>0.278}
      },
      {
        :name=>"ACADEMY 20", :kindergarten_participation=>{2007=>0.391, 2006=>0.353, 2005=>0.267}
      },
      {
        :name=>"ADAMS COUNTY 14", :kindergarten_participation=>{2007=>0.306, 2006=>0.293, 2005=>0.3}
      },
      {
        :name=>"ADAMS-ARAPAHOE 28J", :kindergarten_participation=>{2007=>0.473, 2006=>0.37, 2005=>0.201}
      }
    ]
    assert_equal output, formatted_hashes(@data1)
  end
end
