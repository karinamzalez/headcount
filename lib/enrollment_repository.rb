require "csv"

class EnrollmentRepository
  attr_reader :enrollments

  def initialize
    @enrollments = []
  end

  def find_by_name(name)
    enrollments.find { |enrollment| enrollment.name == name }
  end

  def load_data(enrollment_data)
    #access the file from the data
    kindergarten_file = enrollment_data[:enrollment][:kindergarten]

    # get the csv
    # read all the lines
    raw_csv_data = CSV.open(kindergarten_file,
    headers: true, header_converters: :symbol).map(&:to_h)
    raise raw_csv_data.inspect



    # <----------what will i have here
    # reduce the lines into 1 entry for each district (by name)

    #if the district name (hash[:location]) of the current hash  == )
    #the district name of the next one, reduce those all 
    # <-----------what do i want to have here
    # create a new Enrollment object to hold this info
    # add that into the enrollments array
  end
end
