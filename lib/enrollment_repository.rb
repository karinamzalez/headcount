require "csv"

class EnrollmentRepository
  attr_reader :enrollments

  def initialize
    @enrollments = []
  end

  def find_by_name(name)
    enrollments.find { |enrollment| enrollment.name == name }
  end

  def load_data(data)
    kindergarten_file = data[:enrollment][:kindergarten]

    raw_csv_data = CSV.open(kindergarten_file, headers: true, header_converters: :symbol).map(&:to_h)
    raise raw_csv_data.inspect
    # get the csv
    # read all the lines
    # <----------what will i have here
    # reduce the lines into 1 entry for each district (by name)
    # <-----------what do i want to have here
    # create a new Enrollment object to hold this info
    # add that into the enrollments array
  end
end
