class StatewideTest
  attr_reader :name,
              :data

  def initialize(data)
    @data = data
    @name = data[:name].upcase
  end

  def proficient_by_grade(grade)
    case grade
    when 3
      @data[:third_grade]
    when 8
      @data[:eigth_grade]
    else
      raise "UnknownDataError"
      # begin
      #   raise UnknownDataError
      # end
    end
  end

end
