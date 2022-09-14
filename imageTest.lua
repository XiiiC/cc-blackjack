local nft = require "cc.image.nft"
local image = assert(nft.load("images/cards/clubs/C-10.nfp"))
nft.draw(image, term.getCursorPos())

-- function file_exists(name)
--     local f=io.open(name,"r")
--     if f~=nil then io.close(f) return true else return false end
--  end
-- 
-- if file_exists("images/cards/clubs/C-10.nfp") then
--     print("File exists")
-- else
--     print("File does not exist")
-- 
-- end
