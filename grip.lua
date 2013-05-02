-- main loop of the programm

require "terminal"
require "functions"

version =" 1.0"

print("GNU RIP " .. version .. [[ 
Welcome to GNU RIP, the GNU Recursive Interpretation Processor
By Gwenn Aubert and Bastien Maureille -- 2013
type help for details
]])

predicates = {}

while true do
   cmd = prompt()
   if (cmd == "exit") then
      os.exit()
   end
   if (cmd == "help") then
      help()
   else
      space = string.find(cmd, " ")
      if (space ~= nil) then
	 error(cmd, space,"syntax error: character ' ' unexpected")
      else
	 if (string.find(cmd, "=") ~= nil) then
	    pred, def = split(cmd)
	    print(pred)
	    print(def)
	    uec = string.find(def,"[^zisor<>]")
	    if (uec ~= nil) then
	       error(cmd, uec+string.len(pred)+1, "syntax error: character '" .. def:match("[^zisor<>]") .. "' unexpected")
	    end
	    -- TODO : else pred definition
	 else 
	    pred, args = call(cmd)
	    if (pred == nil) then
	       par_index = string.find(cmd, "%(") or string.find(cmd, "%)") or 0
	       error(cmd, par_index, "syntax error: missing parenthesis")
	    else
	       if (args == nil) then
		  error(cmd, string.len(pred)+1, "syntax error: '"..pred.."' : bad arguments")		  
	       else
		  if (predicates[pred] == nil) then
		    error(cmd, 0, "syntax error: '"..pred.."' is not a predicate")
		  else
		     arguments = split_args(args)
		     -- TODO pred call
		  end
	       end
	    end
	 end
      end
   end
end