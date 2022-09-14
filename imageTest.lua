local nft = require "cc.image.nft"
local image = assert(nft.load("data/example.nft"))
nft.draw(image, term.getCursorPos())