# Adding a count to it this time
input = ARGF.read.lines(chomp: true).map { |l|
  l.split(Regexp.union(" | ", ": "))[1..2].map! { |s|
    s.split.map { |n| n.to_i }
  }
}.map! { |a| a << 1 }

input.each.with_index do |card, i|
  matches = card[1] - (card[1] - card[0])
  card[2].times do
    matches.length.times do |m|
      input[i + 1 + m][2] = input[i + 1 + m][2] + 1
    end
  end
end

puts input.map { |c| c[2] }.sum
