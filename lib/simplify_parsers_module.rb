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
    if percent_data.to_i.to_s == percent_data
      percent_data.to_i
    elsif percent_data == percent_data.to_f.to_s
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
    when "free_or_reduced_price_lunch"
      formatted_data = format_free_reduced_hash_per_line(file, name_of_hash)
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
          iteratively_apply_deep_merge_levels(rows)
      when "eighth_grade_proficiency"
          iteratively_apply_deep_merge_levels(rows)
      when "math"
        iteratively_apply_deep_merge(rows)
      when "reading"
        iteratively_apply_deep_merge(rows)
      when "writing"
        iteratively_apply_deep_merge(rows)
      when "median_household_income"
        iteratively_apply_deep_merge(rows)
      when "children_in_poverty"
        iteratively_apply_deep_merge(rows)
      when "free_or_reduced_price_lunch"
        iteratively_apply_deep_merge_levels(rows)
      when "title_i"
        iteratively_apply_deep_merge(rows)
      end
    end
  end

end
