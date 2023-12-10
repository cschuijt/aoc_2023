def connecting_nodes(char, x, y)
  case char
  when '|'
    return [[x, y + 1], [x, y - 1]]
  when '-'
    return [[x + 1, y], [x - 1, y]]
  when '7'
    return [[x - 1, y], [x, y + 1]]
  when 'F'
    return [[x + 1, y], [x, y + 1]]
  when 'L'
    return [[x + 1, y], [x, y - 1]]
  when 'J'
    return [[x - 1, y], [x, y - 1]]
  else
    # We're on a . and should return
    return []
  end
end

@input = ARGF.read.lines(chomp: true).map { |l| l.chars }

start = []
@input.each.with_index { |l, y| l.each.with_index { |c, x| start = [x, y] if c == 'S' } }
@input.map!.with_index { |l, y| l.map.with_index { |c, x| connecting_nodes(c, x, y) } }

@positions = []
@input.each.with_index { |l, y| l.each.with_index { |p, x|
  @positions << [x, y] if p.include?(start)
} }

i = 1
already_traversed = [start]
while @positions.uniq.count > 1
  i = i + 1
  traversed_size = already_traversed.size
  @positions.each { |p| already_traversed << p }
  @positions.map! { |pos| (@input[pos[1]][pos[0]] - already_traversed).flatten(1) }
  already_traversed.shift(traversed_size)
end

pp i
