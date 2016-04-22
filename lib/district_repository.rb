require 'csv'
require './lib/district'
require 'pry'
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

  def load_data(data)
    kindergarten_file = data[:enrollment][:kindergarten]
    grouped = group_by_name(kindergarten_file)
    grouped.keys.each do |name|
      d = District.new({name: name})
      @districts << d
    end
    enrollment_repo.load_data(data)
    access_enrollments
  end

  def access_enrollments
    districts.map do |district|
      district.enrollment = enrollment_repo.find_by_name(district.name)
    end
  end
end
