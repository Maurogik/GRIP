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

function splitPredFromDef(cmd)
   preds = {}
   defs = {}
   i = 1
   for pred, def in string.gmatch(cmd, "(%w+)=(.+)") do
      preds[i] = pred
      defs[i] = def
      i = i+1
   end
   return preds[1], defs[1]
end

function splitPredicateCall(cmd)
   predicate = {}
   arguments = {}
   i = 1
   args_format = "[%d?(%d+(,%d)*)]"
   for pred, args in string.gmatch(cmd, "(%w+)%((.*)%)") do
      predicate[i] = pred
      arguments[i] = args
      i = i+1
   end

   return predicate[1], arguments[1]
end
   


function split_args(args)
   arguments = {}
   --add the index of the first argument of interest
   arguments[1] = 2
   i = 2
   for arg in string.gmatch(args, "(%d+)") do
      arguments[i] = arg
      i = i+1
   end
   return arguments
end


function preProcessDef(def)

   resDef = {}
   i = 1

   local strTemp = def
   while strTemp do

      indPredStart, indPredEnd = string.find(strTemp, "(%(%w+%))")  
      indSymbStart, indSymbEnd = string.find(strTemp, "([zisor><])")

      if indSymbStart == nil and indPredStart == nil then
         strTemp = nil
      elseif indSymbStart == nil then
         resDef[i] = string.sub(strTemp, indPredStart + 1, indPredEnd - 1)
         strTemp = string.sub(strTemp, indPredEnd + 1)
      elseif indPredStart == nil then
         resDef[i] = string.sub(strTemp, indSymbStart, indSymbEnd)
         strTemp = string.sub(strTemp, indSymbEnd + 1)
      else
         if indSymbStart < indPredStart then
            resDef[i] = string.sub(strTemp, indSymbStart, indSymbEnd)
            strTemp = string.sub(strTemp, indSymbEnd + 1)
         else
            resDef[i] = string.sub(strTemp, indPredStart + 1, indPredEnd - 1)
            strTemp = string.sub(strTemp, indPredEnd + 1)
         end
      end

      i = i + 1
   end

   return resDef
end
