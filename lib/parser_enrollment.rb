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

  def make_base_data(something_is_true, location, name_of_hash,timeframe, some_var)
    if something_is_true
      {name: location, name_of_hash: {timeframe: some_var}}
    end
  end

end
class BaseDatum
  def initialize(....)
    base_common_thing....
    if isFreeReduced
      ...
    else
      ...
    end

    @record = {name: .....}
  end
