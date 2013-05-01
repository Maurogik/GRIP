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
   end
   if (string.find(cmd, "=") ~= nil) then
      space = string.find(cmd, " ")
      if (space ~= nil) then
	 error(cmd, space,"syntax error: character ' ' unexpected")
      else
	 pred, def = split(cmd)
	 print(pred)
	 print(def)
      end
   else 
      space = string.find(cmd, " ")
      if (space ~= nil) then
	 error(cmd, space,"syntax error: character ' ' unexpected")
      else 
	 if (predicates[cmd] == nil) then
	    error(cmd, 0, "syntax error: '"..cmd.."' is not a predicate")
	 end
      end
   end
end