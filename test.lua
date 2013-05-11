


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

    table = {'a','b','c','d'}
    tab2 = {'f'}..table
    for i=1,#tab2 do
      print(tab2[i])
    end

end

test()