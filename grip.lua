require "terminal"

version =" 1.0"

print("GNU RIP " .. version .. [[ 
Welcome to GNU RIP, the GNU Recursive Interpretation Processor
By Gwenn Aubert and Bastien Maureille
april 2013]])

while true do
   cmd = prompt()
   if (cmd == "exit") then
      os.exit()
   end
   if (cmd == "help") then
      help()
   end
end