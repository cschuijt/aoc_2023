def grab_number(line, char)
  first = char
  while first > 0 && DIGITS.any? { |d| d[@input[line][first - 1]] }
    first = first - 1
  end

  last = char
  while @input[line][last + 1] && DIGITS.any? { |d| d[@input[line][last + 1]] }
    last = last + 1
  end

  number = @input[line][first..last].to_i
  # puts "Grabbing #{number} on [#{char}, #{line}]"

  # I don't know if the input contains any numbers that touch more than one
  # symbol, but as a precaution against double counting, we'll just null those
  # out of the input.
  (first..last).each do |n|
    @input[line][n] = '.'
  end

  return number
end

def mark_adjacent_numbers(line, char)
  if line.between?(1, @input.length - 2)
    # We have a line that is somewhere in between the first and last line
    line_range = (line - 1)..(line + 1)
  elsif line == 0
    # We have the first line and should not check above it
    line_range = line..(line + 1)
  else
    # We have the last line and should not check below it
    line_range = (line - 1)..line
  end

  if char.between?(1, @input[0].length - 2)
    # We have a char that is somewhere in between the first and last char
    char_range = (char - 1)..(char + 1)
  elsif char == 0
    # We have the first char and should not check left of it
    char_range = char..(char + 1)
  else
    # We have the last char and should not check right of it
    char_range = (char - 1)..char
  end

  numbers = []

  line_range.each do |line_no|
    char_range.each do |char_no|
      numbers << grab_number(line_no, char_no) if DIGITS.any? { |d| d[@input[line_no][char_no]] }
    end
  end

  if numbers.length == 2
    # puts "Adding gear ratio: #{numbers[0]} * #{numbers[1]} = #{numbers[0] * numbers[1]}"
    @gear_ratios << numbers[0] * numbers[1]
  end
end


@input = ARGF.read.lines.map { |l| l.chomp }
@gear_ratios = []

DIGITS      = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']

@input.each.with_index do |line, line_no|
  line.chars.each.with_index do |char, char_no|
    if char == '*'
      # puts "Looking around #{char} [#{char_no}, #{line_no}]"
      mark_adjacent_numbers(line_no, char_no)
    end
  end
end

puts "Part two: #{@gear_ratios.sum}"
