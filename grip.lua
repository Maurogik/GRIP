-- main loop of the programm

require "terminal"

version =" 1.0"

print("GNU RIP " .. version .. [[ 
Welcome to GNU RIP, the GNU Recursive Interpretation Processor
By Gwenn Aubert and Bastien Maureille -- 2013
type help for details
]])

while true do
   cmd = prompt()
   if (cmd == "exit") then
      os.exit()
   end
   if (cmd == "help") then
      help()
   end
   pred, def = split(cmd)
   print(pred)
   print(def)
end