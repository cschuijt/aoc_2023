@input = ARGF.read.lines(chomp: true).map { |l| l.chars }
EXPANSION = 999999

@expansion_rows = []
@input.size.times do |i|
  if @input[i].uniq.count == 1
    @expansion_rows << i
  end
end

@expansion_cols = (0..(@input[0].size - 1)).to_a.reject { |n| @input.any? { |l| l[n] == '#' } }

@galaxies = []
@input.each.with_index do |l, y|
  l.each.with_index do |c, x|
    @galaxies << [x, y] if c == '#'
  end
end

def distance_between_galaxies(a, b)
  horizontal_distance = (a[0] - b[0]).abs
  vertical_distance   = (a[1] - b[1]).abs

  ((([a[0], b[0]].min)..([a[0], b[0]].max)).to_a & @expansion_cols).size.times do
    horizontal_distance = horizontal_distance + EXPANSION
  end

  ((([a[1], b[1]].min)..([a[1], b[1]].max)).to_a & @expansion_rows).size.times do
    vertical_distance = vertical_distance + EXPANSION
  end

  return horizontal_distance + vertical_distance
end

@total_distance = 0
@galaxies.each do |g|
  @galaxies.each do |og|
    @total_distance = @total_distance + distance_between_galaxies(g, og)
  end
end

puts @total_distance / 2
