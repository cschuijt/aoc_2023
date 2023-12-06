input = ARGF.read.lines.map { |l| l.split[1..-1].map{ |n| n.to_i } }
pairs = []
input[0].length.times { |i| pairs << [input[0][i], input[1][i]] }

solution_counts = []
pairs.each do |pair|
  solutions = 0
  (1..pair[0]).each do |x|
    if (pair[0] - x) * x > pair[1]
      solutions = solutions + 1
    end
  end
  solution_counts << solutions
end

pp   solution_counts
puts solution_counts.inject(:*)
