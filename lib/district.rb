class District
  attr_accessor :enrollment,
                :statewide_test,
                :economic_profile

  attr_reader :name,
              :district_repository

  def initialize(district_name)
    @name = district_name[:name].upcase
  end

end
