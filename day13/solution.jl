function foo(lines; extra=false)
  M = get_matrix(lines)
  if extra
    n = size(M,1)
    M = [M zeros(Int, n); zeros(Int, n)' 0]
  end
  best = -10000
  n = size(M,1)
  for perm in permutations(1:size(M,1))
    i,j = perm[n], perm[1]
    sum = M[i,j] + M[j,i]
    for k = 1:n-1
      i,j = perm[k], perm[k+1]
      sum += M[i,j] + M[j,i]
    end
    best = max(best, sum)
  end
  println("best = $best")
end

function get_matrix(lines)
  names = get_names(lines)
  n = length(names)
  M = zeros(Int, n, n)
  for line in lines
    vline = split(line)
    i = find(vline[1] .== names)[1]
    j = find(vline[end][1:end-1] .== names)[1]
    d = parse(Int, vline[4])
    M[i,j] = (vline[3] == "gain" ? d : -d)
  end
  return M
end

function get_names(lines)
  return unique([split(line)[1] for line in lines])
end

foo(readlines(open("small.input")), extra=true)
foo(readlines(open("input")), extra=true)
