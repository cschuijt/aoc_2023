class Array
  def fixed_size
    i = 0
    i = i + 1 while self[i] && self[i] == '#'
    return i
  end
end

input = ARGF.read.lines(chomp: true).map { |l|
  a = l.split
  a[0] = a[0].chars
  a[1] = a[1].split(',').map { |n| n.to_i }
  a
}

def possible_solution(chars, solution)
  # puts "Checking #{chars} against #{solution}"
  chunks = chars.chunk { |c| c == '#' || c == '?' }.map { |c| c[1] }

  i = 0
  chunks.each do |c|
    next if c.include?('.')

    if !solution[i]
      if c.include?('#')
        # puts "Ran out of solution and encountered another fixed block"
        return false
      else
        return true
      end
    elsif c.size < solution[i]
      next if c.uniq.count == 1 && c.uniq[0] == '?'
      # puts "Block is too small to satisfy solution (#{c.size} vs #{solution[i]})"
      return false
    elsif c.fixed_size > solution[i]
      # puts "Block has been fixed to too many spaces to fit anymore (#{c.fixed_size} vs #{solution[i]})"
      return false
    end

    # We cannot check further...
    break if c.include?('?')
    i = i + 1
  end

  return true
end

def is_solution(chars, solution)
  chunks = chars.chunk { |c| c == '#' }.select { |c| c[0] == true }.map { |c| c[1].size }
  # puts "Checking #{chars} against #{solution}, chunked #{chunks}"
  return (chunks == solution)
end

@num_solutions = 0
def recursive_check(chars, solution)
  if !chars.include?('?')
    @num_solutions = @num_solutions + 1 if is_solution(chars, solution)
    return
  end

  i = 0
  i = i + 1 while chars[i] != '?'

  new_chars = chars.clone
  new_chars[i] = '#'
  if possible_solution(new_chars, solution)
    recursive_check(new_chars, solution)
  end
  new_chars[i] = '.'
  if possible_solution(new_chars, solution)
    recursive_check(new_chars, solution)
  end
end

input.each do |a|
  recursive_check(a[0], a[1])
  puts "Solutions: #{@num_solutions}"
end
