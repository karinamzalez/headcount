class StatewideTest
  attr_reader :name,
              :data,
              :subjects,
              :grades,
              :races

  def initialize(data)
    @data = data
    @name = data[:name].upcase
    @subjects = [:math, :reading, :writing]
    @grades = {3 => :third_grade_proficiency, 8 => :eighth_grade_proficiency}
    @races = [
              :asian, :black, :pacific_islander, :hispanic,
              :native_american, :two_or_more, :white
             ]
  end

  def proficient_by_grade(grade)
    if grades.has_key?(grade)
      @data[grades[grade]]
    else
      raise UnknownDataError
    end
  end

  def proficient_by_race_or_ethnicity(race)
    if races.include?(race)
      @data[race]
    else
      raise UnknownDataError
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

  def proficient_for_subject_by_race_in_year(subject, race, year)
    race_data = proficient_by_race_or_ethnicity(race)
    if race_data.keys.include?(year)
      if subjects.include?(subject)
        race_data[year][subject]
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
