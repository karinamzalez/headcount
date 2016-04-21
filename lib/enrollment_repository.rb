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

    new_data = raw_csv_data.map do |hash|
      hash.delete(:dataformat)
      hash
    end

    new2 = new_data.map do |h|
      {name: h[:location], kindergarten: {h[:timeframe] => h[:data]}}
    end

    grouped = new2.group_by do |hash|
      hash[:name]
    end

    merged = grouped.map do |location, entries|
      {name: location, kindergarten_participation: merged_entries(entries)}
    end

    # make an enrollment for each of those pieces of data
    # and add it to @enrollments
  end

  def merged_entries(entries)
    entries.map do |e|
      e[:kindergarten]
    end.reduce(:merge)
  end

end
