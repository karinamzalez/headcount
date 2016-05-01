module StatewideTestingFormatter

  def math_file(data)
    data[:statewide_testing][:math]
  end

  def reading_file(data)
    data[:statewide_testing][:reading]
  end

  def writing_file(data)
    data[:statewide_testing][:writing]
  end

  def third_grade_file(data)
    data[:statewide_testing][:third_grade]
  end

  def eighth_grade_file(data)
    data[:statewide_testing][:eighth_grade]
  end

  def get_final_formatted_hashes_per_grade(data)
    third = formatted_hashes_per_district(
    third_grade_file(data),"third_grade_proficiency")
    eighth = formatted_hashes_per_district(
    eighth_grade_file(data),"eighth_grade_proficiency")
    [third, eighth].flatten
  end

  def get_final_formatted_hashes_per_subject(data)
    math = formatted_hashes_per_district(math_file(data),"math")
    reading = formatted_hashes_per_district(reading_file(data),"reading")
    writing = formatted_hashes_per_district(writing_file(data),"writing")
    [math, reading, writing].flatten
  end

  def group_by_district_name_2(data)
    formatted_data = get_final_formatted_hashes_per_subject(data)
    formatted_data.group_by do |hash|
      hash[:name]
    end
  end

  def iteratively_apply_merge_multiple_levels(array)
    array.reduce({}) do |hash, row|
       merge_multiple_levels(hash, row)
    end
  end

  def merge_multiple_levels(h1, h2)
    h1.merge(h2) do |key, value1, value2|
      if value1.class == Hash && value2.class == Hash
        value1.merge(value2) do |k, v1, v2|
          if v1.class == Hash && v2.class == Hash
            v1.merge(v2)
          else
            v1
          end
        end
      else
        value1
      end
    end
  end

  def formatted_hashes_per_district_2(data)
    grouped_data = group_by_district_name_2(data)
    grouped_data.map do |ditrict_name, rows|
      iteratively_apply_merge_multiple_levels(rows)
    end
  end

  def group_grade_data_by_district(data)
    grades = get_final_formatted_hashes_per_grade(data)
    grades.group_by do |hash|
      hash[:name]
    end
  end

  def merge_grade_data(data)
    grouped = group_grade_data_by_district(data)
    grouped.values.map do |hash|
      hash.reduce(:merge)
    end
  end

  def group_all_data(data)
    all_data = merge_grade_data(data) + formatted_hashes_per_district_2(data)
    all_data.group_by { |hash| hash[:name] }
  end

  def merge_all_data(data)
    group_all_data(data).values.map { |hash| hash.reduce(:merge) }
  end

end
