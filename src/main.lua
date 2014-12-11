
function main()
  print("!!!bytedata 2 png!!!")
  
  local fileName = arg[1]
  local outPath = arg[2]
  
  print("fileName:"..fileName)
  local file = assert(io.open(fileName,"rb"))
  local fileSize = fsize(file)
  print("fileSize:"..fileSize)

  local pngNameIndex = 1
  
  local startTime = os.clock()
  
--  local t
--  local startIndex,endIndex=0,0
--  for i=0,fileSize do
--    file:seek("set",i)
--    t = file:read(3)
--    if(t == "PNG") then
--      startIndex = i-1
--    elseif(t == "END") then
--      endIndex = i + 7
--      writePngFile(outPath,pngNameIndex,file,startIndex,endIndex)
--      
--      i = endIndex + 1
--      pngNameIndex = pngNameIndex + 1
--    end
--  end
  
  local data = file:read("*all")
  local i = 0
  local e = 0
  while true do
    i = string.find(data,"PNG",i+1)
    if i == nil then break end
    e = string.find(data,"END",i+3)
    if e == nil then break end
    writePngFile(outPath,pngNameIndex,file,i-2,e+6)
    pngNameIndex = pngNameIndex + 1
  end
  
  print("output end!")
  print("costTime:"..os.clock()-startTime)
  file:close()
end

function writePngFile(outPath,index,file,startIndex,endIndex)
  local name = outPath.."/"..index..".png"
  local outFile = io.open(name,"wb")
  file:seek("set",startIndex)
  local data = file:read(endIndex-startIndex)
  outFile:write(data)
  print("output:"..name)
  assert(outFile:close())
end

function fsize (file)
    local current = file:seek()     -- get current position
    local size = file:seek("end")   -- get file size
    file:seek("set", current)       -- restore position
    return size
end



main()