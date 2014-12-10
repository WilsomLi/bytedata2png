
function main()
  print("!!!bytedata 2 png!!!")
  
  local fileName = arg[1]
  print("fileName:"..fileName)
  local file = assert(io.open(fileName,"rb"))
  local fileSize = fsize(file)
  print("fileSize:"..fileSize)
  
--  local data = file:read("*all")

  local pngNameIndex = 1 
  
  local t,startIndex,endIndex
  for i=0,fileSize do
    file:seek("set",i)
    t = file:read(3)
    if(t == "PNG") then
      startIndex = i-1
    elseif(t == "END") then
      endIndex = i + 7
      writePngFile(pngNameIndex,file,startIndex,endIndex)
      
      i = endIndex + 1
      pngNameIndex = pngNameIndex + 1
    end
  end
  
  file:close()
end

function writePngFile(index,file,startIndex,endIndex)
  local name = "asset/out/"..index..".png"
  local outFile = io.open(name,"wb")
  file:seek("set",startIndex)
  local data = file:read(endIndex-startIndex)
  outFile:write(data)
--  print("output:"..name)
  assert(outFile:close())
end

function fsize (file)
    local current = file:seek()     -- get current position
    local size = file:seek("end")   -- get file size
    file:seek("set", current)       -- restore position
    return size
end



main()