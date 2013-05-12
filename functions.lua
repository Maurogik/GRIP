-- functions to build primitiv recursiv functions

--[[
    argument format standard :
    The argument passed to the final function (for exemple identity or successor) must follow this pattern
        [IoI, arg2, arg3, arg4, ..., argN]
    IoI : index of interest : the index of the argument to process, must be between 2 and N
    arg2, arg3, arg... the actual function argument
--]]

--the table containing the know predicates and the {function, arity} data
predicates = {}

function zero(args)
     return 0
end


function identity(args)
    local index = args[1]
    if index > #args then
        print("Error during identity, wrong number of argument")
        return nil
    end
    return args[index]
end


function successor(args)
    local index = args[1]
    if index > #args then
        print("Error during successor, wrong number of argument")
        return nil
    end
    return args[index] + 1
end


--[[
--Generate a composed function
--]]
function generateComposition(func1, others)
    
    print("in generateComposition//////////////")

    local originalFunc = func1[1]
    local arity = func1[2]

    if arity > #others then
        print("ERROR : not enough argument function to compose")
        return nil
    end

    --The maximum arity of the argument functions
    -- ,will be the arrity of the composed function
    local maxArity = 0
    local argFunc = {}
    --only get the needed argument functions
    for i=1,arity do
        argFunc[i] = others[i][1]
        if maxArity < others[i][2] then
            maxArity = others[i][2]
        end
    end
    --Create the composed function
    local modifiedFunc = function (args)

        local newArgs = {}
        newArgs[1] = 2
        for i=1,#argFunc do
            newArgs[i+1] = argFunc[i](args)
        end

        return originalFunc(newArgs)
    end

    return {modifiedFunc, maxArity} 
end


--[[
--Generate a recursion function
--]]
function generateRecursion(func1, func2)

    print("in generateRecursion//////////////")
    --we get the functions and their arity
    local origFunc1 = func1[1]
    local aritFunc1 = func1[2]
    local origFunc2 = func2[1]
    local aritFunc2 = func2[2]

    if aritFunc1 + 2 ~= aritFunc2 then
    --[[if (aritFunc1 ~= 1 or aritFunc2 ~= 3)
        and aritFunc1 ~= 0 or aritFunc2 ~=2 then--]]
        print("ERROR wrong argument arity in recursion")
        print("func1")
        print(aritFunc1)
        print("func2")
        print(aritFunc2)
        return nil
    end

    local modifiedFunc

    --Create the recursion function
    modifiedFunc = function (args)

        print("recurs args")

        for i=1,#args do
            print(args[i])
        end

        local count = args[args[1]]
        print("count")
        print(count)
        if count == 0 or count == nil then
            count = 0
            local newArgs = args
            -- this function will be interested in the x of the (0,x) argument couple
            table.remove(newArgs, 2)
            return origFunc1(newArgs)
        else
            --the argument for the return function : origFunct2
            local newArgs2 = {}
            --the arguments for the recursion function
            local newArgs3 = args
            newArgs3[args[1]] = count - 1

            newArgs2[1] = 2
            newArgs2[2] = count - 1
            newArgs2[3] = modifiedFunc(newArgs3)
            --get the second part of the original arguments (so x for the (0,x) arguments)
            newArgs2[4] = args[args[1]+1]
            return origFunc2(newArgs2)
        end
        --Test
        count = args[args[1]]

    end

    --the returned function arity is this, I hope
    return {modifiedFunc, (aritFunc1+aritFunc2)/2}
end


--[[
--Generate a righ arity modified function
--]]
function right_arity(func)

    print("in right_arity//////////////")

    local originalFunc = func[1]

    local modifiedFunc = function (args)
        --[[
        args[1] = 2
        args[#args + 1] = 0
        --]]
        return originalFunc(args)
    end

    return {modifiedFunc, func[2]+1}
end


--[[
--Generate a left arity modified function
--]]
function left_arity(func)

    print("in left_arity//////////////")

    local originalFunc = func[1]

    local modifiedFunc = function (args)
        args[1] = args[1] + 1
        return originalFunc(args)
    end

    return {modifiedFunc, func[2]+1}
end


--[[
--Concatenate two tables
--]]
function TableConcat(t1,t2)
        for i=1,#t2 do
                t1[#t1+1] = t2[i]
        end
        return t1
end

--basic functions
-- each entry contain the function reference and the function arity
basics = {}
basics["z"] = {zero, 0}
basics["i"] = {identity, 1}
basics["s"] = {successor, 1}
basics["o"] = {generateComposition, 2}
basics["r"] = {generateRecursion, 2}
basics["<"] = {left_arity, 1}
basics[">"] = {right_arity, 1}

symbols = {"z", "i", "s", "o", "r", "<", ">"}

for i=1,#symbols do
    predicates[symbols[i]] = basics[symbols[i]]
end

print(basics["r"][1])
print(basics["r"][2])