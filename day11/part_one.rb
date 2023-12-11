@input = ARGF.read.lines(chomp: true).map { |l| l.chars }
@expanded_input = []

@input.size.times do |i|
  if @input[i].uniq.count == 1
    @expanded_input << @input[i].clone
  end
  @expanded_input << @input[i]
end
@input = @expanded_input

# Add these in reverse to avoid index drifting
(0..(@input[0].size - 1)).to_a.reject { |n| @input.any? { |l| l[n] == '#' } }.reverse.each do |col|
  @input.map! do |l|
    l.insert(col, '.')
  end
end

@galaxies = []
@input.each.with_index do |l, y|
  l.each.with_index do |c, x|
    @galaxies << [x, y] if c == '#'
  end
end

@total_distance = 0
@galaxies.each do |g|
  @galaxies.each do |og|
    @total_distance = @total_distance + (g[0] - og[0]).abs + (g[1] - og[1]).abs
  end
end

puts @total_distance / 2
