require 'csv'

module ParserGrade

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

  def format_hash_per_line(file, name_of_grade)
    cleaned_data = delete_dataformat(file)
    cleaned_data.map do |h|
      {
        name: h[:location], "#{name_of_grade}":
        {
          h[:timeframe].to_i => {:"#{h[:score]}".downcase => clean_data(h[:data])}
        }
      }
    end
  end

  def group_by_name(file, name_of_grade)
    formatted_data = format_hash_per_line(file, name_of_grade)
    formatted_data.group_by do |hash|
      hash[:name]
    end
  end

  def clean_data(percent_data)
    if percent_data == percent_data.to_f.to_s
      percent_data.to_f
    else
      percent_data
    end
  end

  def deep_merge_levels(h1, h2)
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

  def iteratively_apply_deep_merge_levels(array)
    array.reduce({}) do |hash, row|
      deep_merge_levels(hash, row)
    end
  end

  def formatted_hashes_per_district_grade(file,subject)
    grouped_data = group_by_name(file, subject)
    grouped_data.map do |ditrict_name, rows|
      iteratively_apply_deep_merge_levels(rows)
    end
  end

end
