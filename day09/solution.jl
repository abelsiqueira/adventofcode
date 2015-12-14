function foo(filename)
  lines = readlines(open(filename))

  cities = unique(vcat([split(x)[1] for x in lines], [split(x)[3] for x in lines]))
  city_index = Dict{ASCIIString,UInt8}()
  for i = 1:length(cities)
    city_index[cities[i]] = i
  end
  D = zeros(Int, length(cities), length(cities))
  for line in lines
    vline = split(line)
    i = city_index[vline[1]]
    j = city_index[vline[3]]
    v = parse(Int, vline[5])
    D[i,j] = v
    D[j,i] = v
  end

  best = Inf
  worst = 0
  for perm in permutations(1:length(cities))
    sum = 0
    for k = 1:length(perm)-1
      i,j = perm[k], perm[k+1]
      sum += D[i,j]
    end
    best = min(best, sum)
    worst = max(worst, sum)
  end
  println("best = $best, worst = $worst")
end

if length(ARGS) < 1
  println("Need input")
  exit(1)
end

foo(ARGS[1])
