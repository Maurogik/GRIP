-- functions to build primitiv recursiv functions

function zero(args)
   return 0
end

function identity(args, index)
   return args[index]
end

function successor(args, index)
   return args[index]+1
end

function composition(f, g)
   -- TODO
end

function recursion(count, f, g, args, index)
   if (count == 0) then
      return f(args[index])
   end
   return g(TableConcat({count-1, recursion(count-1, f, g, args, index)}, args), index)
end

function right_arity(f, args, index)
   table.insert(args, 0)
   return f(args, index)
end

function left_arity(f, args, index)
   table.insert(args, 0, 0)
   return f(args, index+1)
end

function TableConcat(t1,t2)
    for i=1,#t2 do
        t1[#t1+1] = t2[i]
    end
    return t1
end