input = ARGF.read.split(/\n\n/)

@seeds = input[0].split[1..-1].map { |n| n.to_i }
steps = input[1..-1].map { |step|
  step.split(/\n/)[1..-1].map { |line|
    line.split.map { |number|
      number.to_i
    }
  }
}.map { |step|
  step.map { |array|
    [
      array[1]..(array[1] + array[2] - 1),
      array[0] - array[1]
    ]
  }
}

steps.each do |step|
  @seeds.each.with_index do |seed, index|
    step.each do |range|
      if range[0].include? seed
        @seeds[index] = seed + range[1]
        break
      end
    end
  end
end

puts @seeds.min
