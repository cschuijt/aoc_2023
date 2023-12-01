input = ARGF.read.lines
numbers = []
num_regexes = [/^one/, /^two/, /^three/, /^four/, /^five/, /^six/, /^seven/, /^eight/, /^nine/]

input.each do |line|
  line_number = 0

  line.chars.each.with_index do |c, pos|
    if c.match?(/[[:digit:]]/)
      line_number = c.to_i * 10
      break
    elsif line[pos..-1].match?(Regexp.union(num_regexes))
      line_number = (num_regexes.each_index.detect { |i| num_regexes[i].match?(line[pos..-1]) } + 1) * 10
      break
    end
  end

  line.chars.reverse.each.with_index do |c, pos|
    if c.match?(/[[:digit:]]/)
      line_number = line_number + c.to_i
      break
    elsif line.reverse[0..pos].reverse.match?(Regexp.union(num_regexes)) # This is so scuffed
      line_number = line_number + num_regexes.each_index.detect { |i| num_regexes[i].match?(line.reverse[0..pos].reverse) } + 1
      break
    end
  end

  numbers << line_number
end

puts numbers
puts numbers.sum
