ignore = ['i'-'a'; 'o'-'a'; 'l'-'a']

function foo(str)
  x = fromstr(str)
  while !is_valid(x)
    x = next(x)
    #println("x = $(tostr(x))")
  end
  return tostr(x)
end

function fromstr(str)
  return Int[x-'a' for x in str]
end

function tostr(x)
  return join(['a' + y for y in x])
end

function is_valid(x)
  n = length(x)
  found = false
  for i = 1:n-2
    if x[i] == x[i+1]-1 && x[i+1] == x[i+2]-1
      found = true
      #println("$(tostr(x)): Found at $(tostr(x)[i:i+2])")
      break
    end
  end
  if !found
    return false
  end
  found = 0
  skip_next = false
  for i = 1:n-1
    if skip_next
      skip_next = false
      continue
    end
    if x[i] == x[i+1]
      found += 1
      skip_next = true
      #println("$(tostr(x)): Found at $(tostr(x)[i:i+1])")
      if found == 2
        break
      end
    end
  end
  if found < 2
    return false
  end
  if any(x .== ignore')
    return false
  end
  return true
end

function next(y)
  x = reverse(y)
  n = length(x)
  x[1] += 1
  i = 1
  r = 0
  for i = 1:n-1
    r = div(x[i], 26)
    if r == 0
      break
    end
    x[i] -= 26
    x[i+1] += 1
  end
  if r != 0
    push!(x, 1)
  end
  return reverse(x)
end

#println(foo("hijklmmn"))
#println(foo("abbceffg"))
#println(foo("abbcegjk"))
println(foo("abcdefgh"))
println(foo("ghijklmn"))
x = foo("vzbxkghb")
println(x)
x = tostr(next(fromstr(x)))
println(foo(x))
