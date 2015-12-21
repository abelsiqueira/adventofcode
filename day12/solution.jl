using JSON

function foo(json)
  json = JSON.parse(json)

  s = sum_dict(json)
  println("s = $s")

  return json
end

function sum_dict(dict::Dict)
  if "red" in values(dict)
    return 0
  else
    return sum_vector(collect(values(dict)))
  end
end

function sum_vector(vecs::Vector)
  s = 0
  for v in vecs
    if typeof(v) <: Number
      s += v
    elseif typeof(v) <: Vector
      s += sum_vector(v)
    elseif typeof(v) <: Dict
      s += sum_dict(v)
    end
  end
  return s
end

if length(ARGS) == 0
  println("Need input")
  exit(1)
end

json = foo(ASCIIString(readline(open(ARGS[1]))))
