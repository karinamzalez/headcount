class Enrollment

  attr_accessor :kindergarten_participation_by_year

  def initialize(data)
    @name = data[:name]
    @kindergarten_participation_by_year = data[:kindergarten_participation]
  end

  def kindergarten_participation_in_year(year)
    #want to access the hash at key
    #kindergarten_participation
    #and find the value at key year

    
  end
end
