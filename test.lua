


function test()

    function newCounter ()
      i = 0
      return function ()   -- anonymous function
               i = i + 1
               return i
             end
    end
    
    c1 = newCounter()
    print(i)
    c1()
    print(i)  --> 1
    c1()
    print(i)  --> 2


    print("argstest")
    args = {1,2,3,4}
    args2=args
    table.remove(args2,2)

    for i=1,#args do
      print(args[i])
    end

end

test()