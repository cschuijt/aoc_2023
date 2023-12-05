input = ARGF.read.split(/\n\n/)

pp input

seeds = input[0].split[1..-1].map { |n| n.to_i }
pp seeds
steps = input[1..-1].map { |step|
  step.split(/\n/)[1..-1].map { |line|
    line.split.map { |number|
      number.to_i
    }
  }
}.map { |step|
  step.map { |array|
    [
      array[0]..(array[0] + array[2] - 1),
      array[1] - array[0]
    ]
  }
}

pp steps
