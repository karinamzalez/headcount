class EconomicProfileRepository
  attr_reader :economic_profiles

  def initialize
    @economic_profiles = []
  end

  def find_by_name(name)
    @economic_profiles.find { |profile| profile.name == name.upcase}
  end

  def load_data
    
  end


end
