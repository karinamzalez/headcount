require_relative '../lib/economic_profile_formatter'

class EconomicProfileRepository
  include EconomicProfileFormatter
  attr_reader :economic_profiles

  def initialize
    @economic_profiles = []
  end

  def find_by_name(name)
    @economic_profiles.find { |profile| profile.name == name.upcase}
  end

  def load_data(data)
    merge_all_economic_data(data).each do |hash|
      @economic_profiles << EconomicProfile.new(hash)
    end
  end


end
