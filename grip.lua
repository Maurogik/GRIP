-- main loop of the programm
require "loop"

version =" 1.0"

print("GNU RIP " .. version .. [[ 
Welcome to GNU RIP, the GNU Recursive Interpretation Processor
By Gwenn Aubert and Bastien Maureille -- 2013
type help for details

     °,
      `'
        \ ___
         /   7
        (_/_/\
         \    \
          \    \
          _\    \__
         (   \     )
          \___\___/ 

]])

if (arg[1] ~= nil) then
    print("loading from file ...")
    file = io.open(arg[1])
    reading = true
    count = 1
    while (reading) do
        line = file:read()
        if (line ~= nil) then
            print(count.." "..line)
            main_loop(line)
            count = count + 1
        else
            reading = false
        end
    end
end

while true do
    cmd = prompt()
    main_loop(cmd)
end