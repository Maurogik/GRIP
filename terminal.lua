-- the grip terminal is built here

require "printf"

function prompt()
   printf("grip# ")
   cmd = io.read()
   return cmd
end


function error(cmd, i, msg)
   print("syntax error !")
   print(cmd)
   for x = 0, i-2 do 
      printf(" ")
   end
   printf("^\n%s\n", msg)
end


function help()
   print([[ 
How to use GRIP :
help : display this message
exit : exit the program

z                : zero operator
i                : identity operator
s                : successor operator
<                : change arity on the right
>                : change arity on the left
o                : composition operator
r                : recursion operator
(pred)           : previsouly defined predicate
pred=[predicate] : define "pred" as a new predicate thanks to
	          the previous operators
pred(args)       : call the predicate "pred" with the arguments "args"
]])
end

function split(cmd)
   preds = {}
   defs = {}
   i = 1
   for pred, def in string.gmatch(cmd, "(%w+)=(%w+)") do
      preds[i] = pred
      defs[i] = def
      i = i+1
   end
   return preds[1], defs[1]
end