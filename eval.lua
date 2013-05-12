
--TODO, if not needed clean up the redundant cases in the switch below : NEEDED
--TODO, add arity integreation : as a second value in each function table entry : DONE
--TODO, check the arity functions, I'm not sure about how they should behave : DONE

require "functions"

--The recursive evaluation function, return a table of the evaluated functions and their arity
--After recursing back to the top, the size of the table should always be 1 (if not, ERROR)
--The formula parameter is expected to be a table containing 
-- each of the symbols or predicates saved as strings (one symbol/predicate per entry)
function gripEval(formula)

    print("evaluating : ")

    for i=1,#formula do
        print(formula[i])
    end
    --Not sure about that part, maybe returning nil is better
    -- it all depends on how the tableConcat handle it
    if next(formula) == nil then
        -- myTable is empty
        return {}
    end

    currentExp = formula[1]
    --we don't need this part of the formula anymore
    table.remove(formula, 1)

    --switch over the current expression (symbol or predicate)
    if  currentExp == "z" then

        return TableConcat( {basics["z"]}, gripEval(formula) )

    elseif currentExp == "s" then

        return TableConcat( {basics["s"]}, gripEval(formula) )

    elseif currentExp == "i" then

        return TableConcat( {basics["i"]}, gripEval(formula) )

    elseif currentExp == ">" then

        --evaluate the rest of the formula, we will need it
        temp = gripEval(formula)
        --take the first evaluated function and modify it according to the arity change direction
        modifiedFunc = basics[">"][1](temp[1])
        table.remove(temp, 1)
        return TableConcat( {modifiedFunc}, temp )

    elseif currentExp == "<" then

        --evaluate the rest of the formula, we will need it
        temp = gripEval(formula)
        --take the first evaluated function and modify it according to the arity change direction
        modifiedFunc = basics["<"][1](temp[1])
        table.remove(temp, 1)
        return TableConcat( {modifiedFunc}, temp )

    elseif currentExp == "o" then

        --evaluate the rest of the formula, we will need it
        temp = gripEval(formula)
        firstCompoFunc = temp[1]
        arity = firstCompoFunc[2]
        table.remove(temp, 1)
        --take the first evaluated function FIRST and pass it to the composition
        --along with the other evaluated functions (the compo will use as many as FIRST\arity)
        modifiedFunc = basics["o"][1](firstCompoFunc, temp)
        --remove the functions that have been integrated in the composition
        for i=1,arity do
            table.remove(temp, 1)
        end
        res = TableConcat( {modifiedFunc}, temp )
        return res

    elseif currentExp == "r" then

        --evaluate the rest of the formula, we will need it
        temp = gripEval(formula)
        firstRecFunc = temp[1]
        secondRecFunc = temp[2]
        --remove the used functions
        table.remove(temp, 1)
        table.remove(temp, 1)
        --Create the recursion function with the two needed functions
        modifiedFunc = basics["r"][1](firstRecFunc, secondRecFunc)

        return TableConcat( {modifiedFunc}, temp )

    elseif predicates[currentExp] ~= nil then

        return TableConcat( {predicates[currentExp]}, gripEval(formula) )

    end

    --end of the switch

    return nil

end