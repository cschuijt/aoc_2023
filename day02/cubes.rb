input = ARGF.read.lines

max_red   = 12
max_blue  = 14
max_green = 13

indices = []
powers = []

input.each do |game|
  game_id     = game.split(":")[0][5..-1].to_i
  game_rounds = game.split(":")[1].split(";").map { |s| s.strip }

  possible = true

  min_red   = 0
  min_blue  = 0
  min_green = 0

  game_rounds.each do |round|
    round.split(", ").each do |count|

      if count.match?("red")
        # Part one
        if count.to_i > max_red
          possible = false
        end

        # Part two
        if count.to_i > min_red
          min_red = count.to_i
        end
      elsif count.match?("blue")
        if count.to_i > max_blue
          possible = false
        end

        if count.to_i > min_blue
          min_blue = count.to_i
        end
      elsif count.match?("green")
        if count.to_i > max_green
          possible = false
        end

        if count.to_i > min_green
          min_green = count.to_i
        end
      end
    end
  end

  if possible
    indices << game_id
  end

  power = min_blue * min_red * min_green
  powers << power
end

puts "Part one: #{indices.sum}"
puts "Part two: #{powers.sum}"
