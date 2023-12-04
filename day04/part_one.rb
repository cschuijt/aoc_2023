# Preprocessing to end up with two arrays of numbers
input = ARGF.read.lines(chomp: true).map { |l|
  l.split(Regexp.union(" | ", ": "))[1..2].map! { |s|
    s.split.map { |n| n.to_i }
  }
}

@points = 0
input.each do |card|
  matches = card[1] - (card[1] - card[0])
  @points = @points + 2**(matches.length - 1) if matches.length > 0
end

puts @points
