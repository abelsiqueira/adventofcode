function foo(lines, time)
  best = 0
  for line in lines
    vline = split(line)
    name = vline[1]
    speed = parse(Int, vline[4])
    stamina = parse(Int, vline[7])
    rest = parse(Int, vline[14])

    distance = speed*div(time, stamina+rest)*stamina
    r = time%(stamina+rest)
    distance += min(r,stamina)*speed
    if distance > best
      best = distance
    end

    println("$name $speed $stamina $rest: $distance")
  end
  println("best = $best")
end

function foo2(lines, time)
  n = length(lines)
  speeds = zeros(Int, n)
  staminas = zeros(Int, n)
  rests = zeros(Int, n)
  for (i,line) in enumerate(lines)
    vline = split(line)
    name = vline[1]
    speeds[i] = parse(Int, vline[4])
    staminas[i] = parse(Int, vline[7])
    rests[i] = parse(Int, vline[14])
  end

  distances = zeros(Int, n)
  points = zeros(Int,n)

  for t = 0:time
    for i = 1:n
      if t % (staminas[i]+rests[i]) < staminas[i]
        distances[i] += speeds[i]
      end
    end

    inds = find(distances .== maximum(distances))
    for i in inds
      points[i] += 1
    end
  end

  println("best = $(maximum(distances))")
  println("best points = $(maximum(points))")
end

#foo(readlines(open("small.input")), 1000)
#foo2(readlines(open("small.input")), 1000)
foo(readlines(open("input")), 2503)
foo2(readlines(open("input")), 2503)
