class Colour
  DEFAULT = '0'
  attr_accessor :value
  def initialize(value = DEFAULT)
    @value = value
  end

  def reset
    @value = DEFAULT
  end
end
