class Enrollment
  attr_reader :name,
              :data

  def initialize(data)
    @data = data
    @name = data[:name].upcase
  end

  def truncate_percents(participation_data)
    participation_data.map do |date, percent|
      [date, ("%.3f" % percent.to_s[0..4]).to_f]
    end.to_h
  end

  def kindergarten_participation_by_year
    truncate_percents(data[:kindergarten_participation])
  end

  def kindergarten_participation_in_year(year)
    year.to_s
    kindergarten_participation_by_year[year]
  end

  
end
