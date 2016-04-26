module ParserSubjectProficiency
  def races
    [
      :all_students, :asian, :black, :pacific_islander,
      :hispanic, :native_american, :two_or_more, :white
    ]
  end

  def get_the_raw_data(file)
    CSV.open(file, headers: true, header_converters: :symbol).map(&:to_h)
  end

  def delete_dataformat_only(file)
    raw_csv_data = get_the_raw_data(file)
    raw_csv_data.map do |hash|
      hash.delete(:dataformat)
      hash
    end
  end

  def format_subject_hash_per_line(file, subject)
    cleaned_data = delete_dataformat_only(file)
    cleaned_data.map do |h|
      if h[:race_ethnicity].include?("/")
        x = h[:race_ethnicity].downcase.split("/")[1].split(" ").join("_")
      else
        x = h[:race_ethnicity].downcase.split(" ").join("_")
      end
      {
        name: h[:location], "#{x}":
        {
          h[:timeframe] => {"#{subject}" => h[:data]}
        }
      }
    end
  end

  def group_by_district_name(file, subject)
    formatted_data = format_subject_hash_per_line(file, subject)
    formatted_data.group_by do |hash|
      hash[:name]
    end
  end

  def merged_all_students_per_district(file, subject)
    grouped_d = group_by_district_name(file, subject)
    @all_students = []
    grouped_d.values.map do |array|
      not_merged = []
       races.each do |x|
         not_merged << array.select { |race| race.keys.include?(x) }
      end
      not_merged = not_merged.reject { |l| l == [] }
      flat = not_merged.flatten
    #   @counter = 0
    #   until @counter == 3
    #     flat.each do |hash|
    #     hash1 = hash[:all_students]
    #     hash1.merge(hash[:all_students])
    #     @counter += 1
    #    end
    #    require "pry"; binding.pry
    #  end
      merged = flat[0][:all_students].merge(flat[1][:all_students])
      no_duplicates = not_merged.map { |hash| hash.reduce(:merge) }
      no_duplicates[0][:all_students] = merged
      @all_students << not_merged[0]
    end
  end

  def merged_all_asian_per_district(file, subject)
    grouped_d = group_by_district_name(file, subject)
    @asian = []
    grouped_d.values.map do |array|
      not_merged = []
       races.each do |x|
         not_merged << array.select { |race| race.keys.include?(x) }
      end
      not_merged = not_merged.reject { |l| l == [] }
      flat = not_merged.flatten
      merged = flat[0][:all_students].merge(flat[1][:all_students])
      not_merged = not_merged.map { |hash| hash.reduce(:merge) }
      not_merged[0][:all_students] = merged
      @asian << not_merged[0]
    end
    @asian
  end
end
