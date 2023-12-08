input = ARGF.read.lines(chomp: true)
instructions = input[0]
instr_len    = instructions.length
nodes = {}
input[2..-1].each { |l|
  nodes[l.split[0]] = [l.split[2].gsub(/[\(\)\/,]/, ''),
                       l.split[3].gsub(/[\(\)\/]/, '')  ]
}

intervals = nodes.select { |k,_| k[2] == 'A' }.map { |k, _| k }.map do |current|
  i = 0
  while current[2] != 'Z'
    if instructions[i % instr_len] == 'L'
      current = nodes[current][0]
    else
      current = nodes[current][1]
    end

    i = i + 1
  end

  i
end

puts intervals.reduce(1, :lcm)
