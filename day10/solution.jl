# Took almost 2h and 40 minutes
function iterate(str)
  m = matchall(r"(.)\1*", str)
  out = ""
  for i = 1:length(m)
    out = "$out$(length(m[i]))$(m[i][1])"
  end
  return out
end

s = "3113322113"
for i = 1:50
  s = iterate(s)
  println("$i $(length(s))")
end
println(length(s))
