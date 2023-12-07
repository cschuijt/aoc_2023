def hand_rank(hand)
  case hand.chars.uniq.length # Number of unique characters in hand
  when 1
    return 6 # AAAAA, Five of a kind
  when 2
    if hand.chars.uniq.map { |c| hand.count(c) }.any? { |c| c == 4 }
      return 5 # AAAAB, Four of a kind
    else
      return 4 # AAABB, Full house
    end
  when 3
    if hand.chars.uniq.map { |c| hand.count(c) }.any? { |c| c == 3 }
      return 3 # AAABC, Three of a kind
    else
      return 2 # AABBC, Two pair
    end
  when 4
    return 1 # AABCD, One pair
  else
    return 0 # ABCDE, High card
  end
end

CARDS = ['1', '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A']

puts ARGF.read.lines(chomp: true).map { |l|
  split = l.split
  split[1] = split[1].to_i
  split << hand_rank(split[0])
}.sort_by { |i| i[2] }.slice_when { |left, right| left[2] != right[2] }.to_a
.map { |a|
  a.sort_by { |h| h[0].chars.map { |c| CARDS.find_index(c) } }
}.flatten(1).map.with_index { |h, i| h[1] * (i + 1) }.sum
