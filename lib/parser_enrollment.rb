module ParserEnrollment

  def format_hash_per_line(file, name_of_hash)
    cleaned_data = delete_dataformat(file)
    cleaned_data.map do |h|
      if does_data_exist?(h[:data])
        {
          name: h[:location],
          "#{name_of_hash}": {h[:timeframe].to_i => h[:data][0..4].to_f}
        }
      end
    end.compact
  end

end
