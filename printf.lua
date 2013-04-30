-- the c printf function

function printf(s,...)
   return io.write(s:format(...))
end -- function
