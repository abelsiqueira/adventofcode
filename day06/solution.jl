function foo(filename)
  lights = zeros(Int, 1000, 1000)
  bright = zeros(Int, 1000, 1000)
  for line in readlines(open(filename))
    turn = -1
    bri = 2
    if contains(line, "on")
      turn = 1
      bri = 1
    elseif contains(line, "off")
      turn = 0
      bri = -1
    end

    m = matchall(r"[0-9,]+", line)
    b = map(x->parse(Int,x), split(m[1], ","))
    e = map(x->parse(Int,x), split(m[2], ","))
    for i = b[1]+1:e[1]+1
      for j = b[2]+1:e[2]+1
        bright[i,j] = max(bright[i,j]+bri,0)
        if turn >= 0
          lights[i,j] = turn
        else
          lights[i,j] = 1-lights[i,j]
        end
      end
    end
  end

  return sum(lights), sum(bright)
end

println(foo(ARGS[1]))
