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
@input_b = @input.clone

start = []
@input.each.with_index { |l, y| l.each.with_index { |c, x| start = [x, y] if c == 'S' } }
@input.map!.with_index { |l, y| l.map.with_index { |c, x| connecting_nodes(c, x, y) } }

@positions = []
@input.each.with_index { |l, y| l.each.with_index { |p, x|
  @positions << [x, y] if p.include?(start)
} }

i = 1
part_of_loop = [start, @positions[0], @positions[1]]
already_traversed = [start]
while @positions.uniq.count > 1
  i = i + 1
  traversed_size = already_traversed.size
  @positions.each { |p| already_traversed << p }
  @positions.map! { |pos| (@input[pos[1]][pos[0]] - already_traversed).flatten(1) }
  @positions.each { |p| part_of_loop << p }
  already_traversed.shift(traversed_size)
end

puts "Part 1: #{i}"

part_of_loop.each do |part|
  @input[part[1]][part[0]] = @input_b[part[1]][part[0]]
end

@input.map! { |l| l.map { |c| c.class == String ? c : '.' } }

@line_len  = @input[0].size
@num_lines = @input.size

def flood_fill(x, y, c)
  @input[y][x] = c

  if x > 0 && @input[y][x - 1] == '.'
    flood_fill(x - 1, y, c)
  end

  if x < @line_len - 1 && @input[y][x + 1] == '.'
    flood_fill(x + 1, y, c)
  end

  if y > 0 && @input[y - 1][x] == '.'
    flood_fill(x, y - 1, c)
  end

  if y < @num_lines - 1 && @input[y + 1][x] == '.'
    flood_fill(x, y + 1, c)
  end
end

@north_edge_coords = part_of_loop.reject { |c| ['-', '7', 'F'].include? @input_b[c[1]][c[0]] }

@input.each.with_index do |l, y|
  l.each.with_index do |c, x|
    if c == '.'
      if @north_edge_coords.reject { |c| c[1] != y || c[0] > x }.size.odd?
        flood_fill(x, y, 'I')
      else
        flood_fill(x, y, 'O')
      end
    end
  end
end

count = 0
@input.each { |l| l.each { |c| count = count + 1 if c == 'I' } }

puts "Part two: #{count}"
