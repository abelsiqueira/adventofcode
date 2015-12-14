function foo(filename, W)
  instructions = readlines(open(filename))
  consec = 0
  while length(instructions) > 0
    line = shift!(instructions)
    #println(line)

    vline = split(line)

    try
      var = vline[end]
      if length(vline) == 3
        try
          #println("Trying line $line")
          v = parse(UInt16, vline[1])
          if ! (var in keys(W))
            W[var] = v
          end
        catch
          W[var] = W[vline[1]]
        end
      elseif length(vline) == 4
        W[var] = ~W[vline[2]]
      elseif length(vline) == 5
        v1 = 0
        try
          v1 = parse(UInt16, vline[1])
          #println("v1 = $v1")
        catch
          v1 = W[vline[1]]
          #println("v1 = W[$(vline[1])] = $v1")
        end
        v2 = 0
        try
          v2 = parse(UInt16, vline[3])
          #println("v2 = $v2")
        catch
          v2 = W[vline[3]]
          #println("v2 = W[$(vline[3])] = $v2")
        end
        #println("  $(typeof(v1))")
        #println("  $(typeof(v2))")
        #println("var = $var")
        if vline[2] == "AND"
          W[var] = v1 & v2
        elseif vline[2] == "OR"
          W[var] = v1 | v2
        elseif vline[2] == "LSHIFT"
          W[var] = v1 << v2
        elseif vline[2] == "RSHIFT"
          W[var] = v1 >> v2
        else
          #println("vline[2] = $(vline[2])")
        end
      end
      consec = 0
    catch e
      #println(e)
      push!(instructions, line)
    end
    #println(length(instructions))
    #print_dict(W)
    consec += 1
    if consec > 2*length(instructions)
      break
    end
  end

  return W
end

function print_dict(W)
  for k in keys(W)
    println("$k = $(W[k])")
  end
end

if length(ARGS) == 0
  exit(1)
end

W = Dict{ASCIIString, UInt16}()
W = foo(ARGS[1], W)
a = W["a"]
println("a = $a")
W = Dict{ASCIIString, UInt16}()
W["b"] = a
W = foo(ARGS[1], W)
a = W["a"]
#print_dict(W)
println("a = $a")
