require 'csv'

module SimplifyParsers

  def get_raw_data(file)
    CSV.open(file, headers: true, header_converters: :symbol).map(&:to_h)
  end

  def delete_dataformat(file)
    raw_csv_data = get_raw_data(file)
    raw_csv_data.map do |hash|
      hash.delete(:dataformat)
      hash
    end
  end

  def clean_data(percent_data)
    if percent_data == percent_data.to_f.to_s
      percent_data.to_f
    else
      percent_data
    end
  end

  def group_by_district_name(file, name_of_hash)
    case name_of_hash
    when "third_grade_proficiency"
      formatted_data = format_grade_hash_per_line(file, name_of_hash)
    when "eighth_grade_proficiency"
      formatted_data = format_grade_hash_per_line(file, name_of_hash)
    when "math"
      formatted_data = format_subject_hash_per_line(file, name_of_hash)
    when "reading"
      formatted_data = format_subject_hash_per_line(file, name_of_hash)
    when "writing"
      formatted_data = format_subject_hash_per_line(file, name_of_hash)
    when "children_in_poverty"
      formatted_data = format_poverty_hash_per_line(file, name_of_hash)
    when "median_household_income"
      formatted_data = format_median_income_hash_per_line(file, name_of_hash)
    else
      formatted_data = format_hash_per_line(file, name_of_hash)
    end
      formatted_data.group_by do |hash|
        hash[:name]
    end
  end

  def formatted_hashes_per_district(file, name_of_hash)
    grouped_data = group_by_district_name(file, name_of_hash)
    grouped_data.map do |ditrict_name, rows|
      case name_of_hash
      when "third_grade_proficiency"
          iteration = iteratively_apply_deep_merge_levels(rows)
      when "eighth_grade_proficiency"
          iteration = iteratively_apply_deep_merge_levels(rows)
      when "math"
        iteration = iteratively_apply_deep_merge(rows)
      when "reading"
        iteration = iteratively_apply_deep_merge(rows)
      when "writing"
        iteration = iteratively_apply_deep_merge(rows)
      when "median_household_income"
        iteration = iteratively_apply_deep_merge(rows)
      end
    end
  end

end
