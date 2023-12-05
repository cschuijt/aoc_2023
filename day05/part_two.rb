input = ARGF.read.split(/\n\n/)

@seeds = input[0].split[1..-1].each_slice(2).map { |range|
  (range[0].to_i)..(range[0].to_i + range[1].to_i - 1)
}

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
  # puts "Considering #{step}"
  new_seeds = []
  @seeds.each.with_index do |seed, index|
    # Store state outside of step loop
    seed_processed = false

    step.each do |range|
      if range[0].cover?(seed)
        # puts "Seed #{seed} covered by range #{range[0]}, adding #{range[1]}"
        new_seeds << ((seed.first + range[1])..(seed.last + range[1]))
        seed_processed = true
      elsif seed.cover?(range[0])
        # puts "Range #{range[0]} covered by seed #{seed}, splitting in three and adding #{range[1]}"
        new_seeds << range[0]
        if seed.first < range[0].first
          @seeds << ((seed.first)..(range[0].first - 1))
        end
        if seed.last > range[0].last
          @seeds << ((range[0].last + 1)..seed.last)
        end
        seed_processed = true
      elsif ((seed.first <= range[0].last) and (range[0].first <= seed.last))
        # puts "Partial overlap between #{range[0]} and #{seed}, splitting in two and adding #{range[1]}"
        # Overlap on either edge: break range up in two,
        # overlapping range gets transformed for next step,
        # other range gets readded
        if seed.first < range[0].first
          # Seed:  |---------|
          # Range:       |---------|
          overlap = (range[0].first)..(seed.last)
          rest    = (seed.first)..(range[0].first - 1)
        else
          # Seed:       |---------|
          # Range: |---------|
          overlap = (seed.first)..(range[0].last)
          rest    = (range[0].last + 1)..(seed.last)
        end
        new_seeds << ((overlap.first + range[1])..(overlap.last + range[1]))
        @seeds    << ((rest.first)..(rest.last))
        seed_processed = true
      end

      break if seed_processed
    end

    # If the seed did not match any ranges, we add it to the new array as-is
    if !seed_processed
      # puts "Nothing to do with #{seed}, copying"
      new_seeds << seed
    end
  end

  @seeds = new_seeds.map { |s| s.class == Range ? s : s..s }

  # pp @seeds
end

@seeds.sort_by! { |r| r.first }

puts @seeds.first.first
