class Config
  attr_accessor :name, :password
  def initialize(name, password = nil, options = {})
    @name = name
    @password = password || "i<3evil"

    if options[:downcase]
      @name.downcase!
    end

    if options[:upcase]
      @name.upcase!
    end

  end
end
