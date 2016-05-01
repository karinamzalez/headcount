require_relative '../lib/enrollment'
require_relative '../lib/parser_enrollment'
require_relative '../lib/enrollment_repository_formatter'
require_relative '../lib/simplify_parsers_module'
require_relative '../lib/parser_subject_proficiency'

class EnrollmentRepository
  include ParserEnrollment
  include ParserSubjectProficiency
  include SimplifyParsers
  include EnrollmentFormatter

  attr_reader :enrollments

  def initialize
    @enrollments = []
  end

  def find_by_name(name)
    enrollments.find { |enrollment| enrollment.name == name.upcase }
  end

  def load_data(data)
    formatted_hashes(data).each do |hash|
      @enrollments << Enrollment.new(hash)
    end
  end

end
