
class Coord
  attr_reader :row,
              :col

  attr_accessor :min,
                :max

  def initialize(row, col, min: 0, max: 250)
    #@min, @max = min, max

    #this.row = row
    #this.col = col
  end
end

