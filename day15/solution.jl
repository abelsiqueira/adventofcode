function foo(lines)
  n = length(lines)
  M = zeros(Int, n, 4)
  cal = zeros(Int, n)
  for i = 1:n
    vline = split(lines[i])
    for j = 1:4
      M[i,j] = parse(Int, vline[1+2*j][1:end-1])
    end
    cal[i] = parse(Int, vline[11])
  end

  max = 100
  cal_restriction = 500

  x = zeros(Int, n)
  x[n] = max
  done = false
  best = 0
  while !done
    if dot(cal, x) == cal_restriction
      v = M'*x
      v = all(v .> 0) ? prod(v) : 0
      if v > best
        best = v
      end
      #println("x = $x")
    end
    done = next(x, max)
  end
  println("best = $best")
end

function next(x, max=100)
  n = length(x)
  feas = false
  while !feas
    x[1] += 1
    j = 1
    while x[j] > max
      x[j] -= max
      j += 1
      if j == n
        return true
      end
      x[j] += 1
    end
    x[n] = max-sum(x[1:n-1])
    if x[n] >= 0
      feas = true
    end
  end
  return false
end

#foo( readlines(open("small.input")) )
foo( readlines(open("input")) )
