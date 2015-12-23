function foo()
  iter = 100
  lines = readlines(open("input"))
  #iter = 5
  #lines = readlines(open("small.input"))
  n = length(lines)
  M = zeros(Bool, n, n)
  for i = 1:n
    for j = 1:n
      M[i,j] = lines[i][j] == '#'
    end
  end
  M[1,1] = M[1,n] = M[n,1] = M[n,n] = true
  #printstr(M)
  for i = 1:iter
    M = next(M)
    #printstr(M)
  end
  println("s = $(sum(M))")
end

function printstr(M)
  n = size(M,1)
  for i = 1:n
    println(join([x ? '#' : '.' for x in M[i,:]]))
  end
  println("")
end

function next(M)
  n = size(M,1)
  N = zeros(Bool, n, n)
  for i = 1:n
    for j = 1:n
      I = max(1,i-1):min(n,i+1)
      J = max(1,j-1):min(n,j+1)
      neighs = sum(M[I,J]) - M[i,j]
      if (M[i,j] && neighs in [2,3]) || (!M[i,j] && neighs == 3)
        N[i,j] = true
      end
    end
  end
  N[1,1] = N[1,n] = N[n,1] = N[n,n] = true
  return N
end

foo()
