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

        local count = args[args[1]]

        if count == 0 or count == nil then

            local newArgs = deepTableCopy(args)
            -- this function will be interested in the x of the (0,x) argument couple
            table.remove(newArgs, newArgs[1])

            local recRes = origFunc1(newArgs)

            return recRes
        else
            --the argument for the return function : origFunct2
            local newArgs2 = {}
            --the arguments for the recursion function
            local newArgs3 = deepTableCopy(args)
            newArgs3[args[1]] = count - 1

            newArgs2[1] = 2
            newArgs2[2] = count - 1
            newArgs2[3] = modifiedFunc(newArgs3)

            --get the second part of the original arguments (so x for the (0,x) arguments)
            newArgs2[4] = args[args[1]+1]

            local recRes = origFunc2(newArgs2)

            return recRes
        end

    end

    --the returned function arity is this, I hope
    return {modifiedFunc, (aritFunc1+aritFunc2)/2}
end


--[[
--Generate a righ arity modified function
--]]
function right_arity(func)

    local originalFunc = func[1]

    local modifiedFunc = function (args)
        args2 = deepTableCopy(args)
        return originalFunc(args2)
    end

    return {modifiedFunc, func[2]+1}
end


--[[
--Generate a left arity modified function
--]]
function left_arity(func)

    local originalFunc = func[1]

    local modifiedFunc = function (args)

        args2 = deepTableCopy(args)
        args2[1] = args2[1] + 1
        return originalFunc(args2)
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

--[[
--Lua passes all tables by reference...wich is really anoying when you spend hours looking for a bug
-- which was only due to tables not beeing copied
-- So... here is the copy function
--]]
function deepTableCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepTableCopy(orig_key)] = deepTableCopy(orig_value)
        end
        setmetatable(copy, deepTableCopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
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
