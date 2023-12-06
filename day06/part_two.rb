input = ARGF.read.lines.map { |l| l.split[1..-1].inject(:+).delete(' ').to_i }

solutions = 0
(1..input[0]).each do |x|
  if (input[0] - x) * x > input[1]
    solutions = solutions + 1
  end
end

puts solutions
