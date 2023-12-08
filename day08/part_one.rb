input = ARGF.read.lines(chomp: true)
instructions = input[0]
instr_len    = instructions.length
nodes = {}
input[2..-1].each { |l|
  nodes[l.split[0]] = [l.split[2].gsub(/[\(\)\/,]/, ''),
                       l.split[3].gsub(/[\(\)\/]/, '')  ]
}

current = 'AAA'
loop.with_index do |_, i|
  if current == 'ZZZ'
    puts i
    break
  else
    if instructions[i % instr_len] == 'L'
      current = nodes[current][0]
    else
      current = nodes[current][1]
    end
  end
end
