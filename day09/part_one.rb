input = ARGF.read.lines(chomp: true).map { |l| l.split.map { |n| n.to_i } }
output = []

input.each do |line|
  steps = [line]
  current = line
  while !(current.all? { |i| i == 0 })
    new_array = []
    current.each_cons(2) do |a, b|
      new_array << b - a
    end
    steps.prepend(new_array.clone)
    current = new_array
  end

  steps[0].append(0)
  steps[1..-1].each.with_index do |step, i|
    steps[i + 1].append(steps[i + 1].last + steps[i].last)
  end

  output << steps.last.last
end

puts output.sum
