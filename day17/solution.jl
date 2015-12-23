function foo()
  cap = 150
  lines = readlines(open("input"))
  lines = map(x->parse(Int, x), lines)

  min_num_container = Inf
  min_count = 0
  count = 0
  n = length(lines)
  for x = 1:2^n-1
    I = [c == '1' ? true : false for c in bin(x,n)]
    if sum(lines[I]) == cap
      count += 1
      if sum(I) < min_num_container
        min_num_container = sum(I)
        min_count = 1
      elseif sum(I) == min_num_container
        min_count += 1
      end
    end
  end
  println("count = $count")
  println("min_count = $min_count")
end

foo()
