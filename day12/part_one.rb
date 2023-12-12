def chars_to_regex(chars)
  regex = ''
  chars.each do |c|
    case c
    when '.'
      regex << '\\.'
    when '#'
      regex << '#'
    else
      regex << '.'
    end
  end
  return Regexp.new(regex)
end

input = ARGF.read.lines(chomp: true).map { |l|
  a = l.split
  a[0] = a[0].chars
  a[1] = a[1].split(',').map { |n| n.to_i }
  a[2] = chars_to_regex(a[0])
  a
}

pp input
