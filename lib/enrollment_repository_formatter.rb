module EnrollmentFormatter

  def kindergarten_file(data)
    data[:enrollment][:kindergarten]
  end

  def graduation_file(data)
    data[:enrollment][:high_school_graduation]
  end

  def formatted_hashes_per_enrollment(data)
    kinder = formatted_hashes_per_district(kindergarten_file(data), "kindergarten_participation")
    if data[:enrollment][:high_school_graduation].nil?
      formatted = kinder
    else
      grad = formatted_hashes_per_district(graduation_file(data), "high_school_graduation")
    formatted = [kinder, grad].flatten
    end
    formatted
  end

  def group_by_district_name_enrollment(data)
    grouped = formatted_hashes_per_enrollment(data)
    grouped.group_by do |hash|
      hash[:name]
    end
  end

  def formatted_hashes(data)
    group_by_district_name_enrollment(data).values.map { |hash| hash.reduce(:merge) }
  end

end
