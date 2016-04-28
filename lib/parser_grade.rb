module ParserGrade

  def format_grade_hash_per_line(file, name_of_grade)
    cleaned_data = delete_dataformat(file)
    cleaned_data.map do |h|
      {
        name: h[:location], "#{name_of_grade}":
        {
          h[:timeframe].to_i => {:"#{h[:score]}".downcase =>
          clean_data(h[:data])}
        }
      }
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

end
