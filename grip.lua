-- main loop of the programm

require "terminal"
require "functions"
require "eval"

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
                pred, def = splitPredFromDef(cmd)
                print(pred)
                print(def)
                otherThanSymb = string.find(def,"[^zisor<>]")
                validPredicateStr = string.find(def,"(.+)")
                if (uec ~= nil and validPredicateStr == nil) then
                     error(cmd, uec+string.len(pred)+1, "syntax error: character '" .. def:match("[^zisor<>]") .. "' unexpected")
                else
                        -- TODO : else pred definition
                        betterDef = preProcessDef(def)
                        sucess, resEval = pcall(gripEval,betterDef)
                        if sucess then
                            if #resEval > 1 then
                                    print("warning : eval result should only return 1 function")
                            end

                            predicates[pred] = resEval[1]
                        else
                            print("ERROR : unable to evaluate expression, check for semantical non-sense")
                            print(resEval)
                        end

                        
                end
                
         else 
                pred, args = splitPredicateCall(cmd)
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

                         if #arguments - 1 < predicates[pred][2] then
                            print("ERROR : not enough arguments")
                        else
                             -- TODO pred call
                             print("arg : ")
                             for i=1,#arguments do
                                     print(arguments[i])
                             end

                            sucess, resEval = pcall(predicates[pred][1],arguments)
                            if sucess then
                                 print("///////RESULT//////")
                                 print(resEval)

                            else
                                print("ERROR : unable to compute : bad arguments")
                                print(resEval)
                            end

                        end

                    end
                     end
                end
         end
            end
     end
end