class StatewideTest
  attr_reader :name,
              :data,
              :subjects,
              :grades

  def initialize(data)
    @data = data
    @name = data[:name].upcase
    @subjects = [:math, :reading, :writing]
    @grades = [3, 8]
  end

  # def grade_to_data_key(grade)
  #   if grade == 3
  #     @data[:third_grade_proficiency]
  #   elsif grade == 8
  #     @data[:eigth_grade_proficiency]
  #   end
  # end

  def proficient_by_grade(grade)
    case grade
    when 3
      @data[:third_grade_proficiency]
    when 8
      @data[:eigth_grade_proficiency]
    else
      raise UnknownDataError
    end
  end

  def proficient_by_race_or_ethnicity(race)
    case race
    when :asian
      @data[:asian_proficiency]
    when :black
      @data[:black_proficiency]
    when :pacific_islander
      @data[:pacific_islander_proficiency]
    when :hispanic
      @data[:hispanic_proficiency]
    when :native_american
      @data[:native_american_proficiency]
    when :two_or_more
      @data[:two_or_more_proficiency]
    when :white
      @data[:white_proficiency]
    else
      raise UnknownRaceError
    end
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
      grade_data = proficient_by_grade(grade)
      if grade_data.keys.include?(year)
        if subjects.include?(subject)
          grade_data[year][subject]
        else
          raise UnknownDataError
        end
      else
        raise UnknownDataError
      end
  end

end

class UnknownDataError < Exception
end

class UnknownRaceError < Exception
end
