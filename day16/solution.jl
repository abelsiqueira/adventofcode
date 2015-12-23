function foo(lines, restrict)
  gts = restrict ? ["cats", "trees"] : []
  lts = restrict ? ["pomeranians", "goldfish"] : []
  ticker = get_ticker()
  for line in lines
    vline = split(line, r"(, |: )")
    sue = split(vline[1])[2]
    n = div(length(vline)-1, 2)
    found = true
    for j = 1:n
      k = vline[2j]
      v = parse(Int, vline[1+2j])
      if ( k in gts && v <= ticker[k] ) ||
         ( k in lts && v >= ticker[k] ) ||
         ( !(k in gts || k in lts) && v != ticker[k] )
        found = false
        break
      end
    end
    if found
      println("sue = $sue")
      return
    end
  end
end

function get_ticker()
  lines = readlines(open("ticker"))
  n = length(lines)
  ticker = Dict{ASCIIString, Int}()
  for line in lines
    vline = split(line)
    ticker[vline[1][1:end-1]] = parse(Int, vline[2])
  end
  return ticker
end

foo( readlines(open("input")), false)
foo( readlines(open("input")), true)
