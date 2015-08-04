
require 'benchmark'

n = 10
c = 1000
s = 1000

# Create a 2d data structure and populate it with 0 as a default value
def create_array_new(size)
  Array.new(size) { Array.new(size) { '0' } }
end

def change_array_new(size)
  @array[rand(size), rand(size)] = '1'
end

def create_hash(size)
  bitmap = {}
  0.upto(size) do |x|
    0.upto(size) do |y|
      bitmap[[x, y]] = '0'
    end
  end
  bitmap
end

def change_hash(size)
  @hash[[rand(size), rand(size)]] = '1'
end

require 'matrix'

def create_matrix(size)
  Matrix.build(size, size) { '0' }
end

def change_matrix(size)
  tmp = @matrix.to_a
  tmp[rand(size), rand(size)] = '1'
  @matrix = Matrix[tmp]
end

@matrix = create_matrix(s)
@array = create_array_new(s)
@hash = create_hash(s)


Benchmark.bm(25) do |x|
  x.report("array") { n.times do create_array_new(s) end }
  # NOTE -SLOW!!!
  x.report("hash") { 1.times do  create_hash(s) end }
  x.report("matrix") { n.times do create_matrix(s) end }

  x.report("change array") { c.times do change_array_new(s) end }
  x.report("change hash") { c.times do change_hash(s) end }
  x.report("change matrix") { c.times do change_matrix(s) end }
end
