require 'csv'
require './lib/district'
require './lib/enrollment_repository'
require './lib/parser'

class DistrictRepository
  include Parser

  attr_accessor :districts
  attr_reader :enrollment_repo

  def initialize
    @enrollment_repo = EnrollmentRepository.new
    @districts = []
  end

  def find_by_name(name)
    districts.find { |d| d.name == name }
  end

  def load_kindergarten_data(data)
    kindergarten_file = data[:enrollment][:kindergarten]
    grouped_district_data = group_by_name(kindergarten_file)
    make_districts_by_name(grouped_district_data)
    enrollment_repo.load_data(data)
    access_enrollments
  end

  def make_districts_by_name(grouped_district_data)
    grouped_district_data.keys.each do |name|
      d = District.new({name: name})
      @districts << d
    end
  end

  def access_enrollments
    districts.map do |district|
      district.enrollment = enrollment_repo.find_by_name(district.name)
    end
  end
end
