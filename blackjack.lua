-- Blackjack game

-- SETUP

local monitor = peripheral.find("monitor")
assert(monitor~=nil, "no monitor connected =[")
local monitorX, monitorY = monitor.getSize()
assert((monitorX==29 and monitorY==26) or (monitorX==57 and monitorY==52), "Monitor should be 3 wide and 4 tall! I believe in you. You're almost there! =D")

term.redirect(monitor)
term.clear()
monitor.setTextScale(0.5)
term.setCursorPos(10, 13)
term.write("loading...")


-- CONSTANTS

playerHand = {}
houseHand = {}


local playerCardWidth = 1*14-1
playerCardPosX = math.floor(57/2-playerCardWidth/2)+1

value = {"A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"}
suit = {"C", "D", "H", "S"}

deck = {}

-- IMAGES

local cards = {
	["C-A"] = paintutils.loadImage("cc-blackjack/images/cards/clubs/C-A.nfp"),
	["C-2"] = paintutils.loadImage("cc-blackjack/images/cards/clubs/C-2.nfp"),
	["C-3"] = paintutils.loadImage("cc-blackjack/images/cards/clubs/C-3.nfp"),
	["C-4"] = paintutils.loadImage("cc-blackjack/images/cards/clubs/C-4.nfp"),
	["C-5"] = paintutils.loadImage("cc-blackjack/images/cards/clubs/C-5.nfp"),
	["C-6"] = paintutils.loadImage("cc-blackjack/images/cards/clubs/C-6.nfp"),
	["C-7"] = paintutils.loadImage("cc-blackjack/images/cards/clubs/C-7.nfp"),
	["C-8"] = paintutils.loadImage("cc-blackjack/images/cards/clubs/C-8.nfp"),
	["C-9"] = paintutils.loadImage("cc-blackjack/images/cards/clubs/C-9.nfp"),
	["C-10"] = paintutils.loadImage("cc-blackjack/images/cards/clubs/C-10.nfp"),
	["C-J"] = paintutils.loadImage("cc-blackjack/images/cards/clubs/C-J.nfp"),
	["C-Q"] = paintutils.loadImage("cc-blackjack/images/cards/clubs/C-Q.nfp"),
	["C-K"] = paintutils.loadImage("cc-blackjack/images/cards/clubs/C-K.nfp"),
	["D-A"] = paintutils.loadImage("cc-blackjack/images/cards/diamonds/D-A.nfp"),
	["D-2"] = paintutils.loadImage("cc-blackjack/images/cards/diamonds/D-2.nfp"),
	["D-3"] = paintutils.loadImage("cc-blackjack/images/cards/diamonds/D-3.nfp"),
	["D-4"] = paintutils.loadImage("cc-blackjack/images/cards/diamonds/D-4.nfp"),
	["D-5"] = paintutils.loadImage("cc-blackjack/images/cards/diamonds/D-5.nfp"),
	["D-6"] = paintutils.loadImage("cc-blackjack/images/cards/diamonds/D-6.nfp"),
	["D-7"] = paintutils.loadImage("cc-blackjack/images/cards/diamonds/D-7.nfp"),
	["D-8"] = paintutils.loadImage("cc-blackjack/images/cards/diamonds/D-8.nfp"),
	["D-9"] = paintutils.loadImage("cc-blackjack/images/cards/diamonds/D-9.nfp"),
	["D-10"] = paintutils.loadImage("cc-blackjack/images/cards/diamonds/D-10.nfp"),
	["D-J"] = paintutils.loadImage("cc-blackjack/images/cards/diamonds/D-J.nfp"),
	["D-Q"] = paintutils.loadImage("cc-blackjack/images/cards/diamonds/D-Q.nfp"),
	["D-K"] = paintutils.loadImage("cc-blackjack/images/cards/diamonds/D-K.nfp"),
	["H-A"] = paintutils.loadImage("cc-blackjack/images/cards/hearts/H-A.nfp"),
	["H-2"] = paintutils.loadImage("cc-blackjack/images/cards/hearts/H-2.nfp"),
	["H-3"] = paintutils.loadImage("cc-blackjack/images/cards/hearts/H-3.nfp"),
	["H-4"] = paintutils.loadImage("cc-blackjack/images/cards/hearts/H-4.nfp"),
	["H-5"] = paintutils.loadImage("cc-blackjack/images/cards/hearts/H-5.nfp"),
	["H-6"] = paintutils.loadImage("cc-blackjack/images/cards/hearts/H-6.nfp"),
	["H-7"] = paintutils.loadImage("cc-blackjack/images/cards/hearts/H-7.nfp"),
	["H-8"] = paintutils.loadImage("cc-blackjack/images/cards/hearts/H-8.nfp"),
	["H-9"] = paintutils.loadImage("cc-blackjack/images/cards/hearts/H-9.nfp"),
	["H-10"] = paintutils.loadImage("cc-blackjack/images/cards/hearts/H-10.nfp"),
	["H-J"] = paintutils.loadImage("cc-blackjack/images/cards/hearts/H-J.nfp"),
	["H-Q"] = paintutils.loadImage("cc-blackjack/images/cards/hearts/H-Q.nfp"),
	["H-K"] = paintutils.loadImage("cc-blackjack/images/cards/hearts/H-K.nfp"),
	["S-A"] = paintutils.loadImage("cc-blackjack/images/cards/spades/S-A.nfp"),
	["S-2"] = paintutils.loadImage("cc-blackjack/images/cards/spades/S-2.nfp"),
	["S-3"] = paintutils.loadImage("cc-blackjack/images/cards/spades/S-3.nfp"),
	["S-4"] = paintutils.loadImage("cc-blackjack/images/cards/spades/S-4.nfp"),
	["S-5"] = paintutils.loadImage("cc-blackjack/images/cards/spades/S-5.nfp"),
	["S-6"] = paintutils.loadImage("cc-blackjack/images/cards/spades/S-6.nfp"),
	["S-7"] = paintutils.loadImage("cc-blackjack/images/cards/spades/S-7.nfp"),
	["S-8"] = paintutils.loadImage("cc-blackjack/images/cards/spades/S-8.nfp"),
	["S-9"] = paintutils.loadImage("cc-blackjack/images/cards/spades/S-9.nfp"),
	["S-10"] = paintutils.loadImage("cc-blackjack/images/cards/spades/S-10.nfp"),
	["S-J"] = paintutils.loadImage("cc-blackjack/images/cards/spades/S-J.nfp"),
	["S-Q"] = paintutils.loadImage("cc-blackjack/images/cards/spads/S-Q.nfp"),
	["S-K"] = paintutils.loadImage("cc-blackjack/images/cards/spades/S-K.nfp"),
}

local cardBack = paintutils.loadImage("cc-blackjack/images/cards/cardBack.nfp")

-- FUNCTIONS

function generateDeck()
	for i = 1, 4 do
		for j = 1, 13 do
			table.insert(deck, suit[i] .. "-" .. value[j])
		end
	end
end

function shuffleDeck()
	for i = 1, 100 do
		local card1 = math.random(1, 52)
		local card2 = math.random(1, 52)
		deck[card1], deck[card2] = deck[card2], deck[card1]
	end
end

function dealCard()
	local card = deck[1]
	table.remove(deck, 1)
	return card
end

function getHandValue(hand)
	local value = 0
	local aces = 0
	for i = 1, #hand do
		local card = hand[i]

		local cardSuit,cardValue = string.match(card, "(.*)%-(.*)")

		if cardValue:sub(1, 1) == "A" then
			value = value + 11
			aces = aces + 1
		elseif cardValue:sub(1, 1) == "J" or cardValue:sub(1, 1) == "Q" or cardValue:sub(1, 1) == "K" then
			value = value + 10
		else
			value = value + tonumber(cardValue:sub(1, 2))
		end
	end
	while value > 21 and aces > 0 do
		value = value - 10
		aces = aces - 1
	end
	return value
end

function getHouseHandValue(hand)
	local value = 0
	local aces = 0
	for i = 2, #hand do
		local card = hand[i]

		local cardSuit,cardValue = string.match(card, "(.*)%-(.*)")

		if cardValue:sub(1, 1) == "A" then
			value = value + 11
			aces = aces + 1
		elseif cardValue:sub(1, 1) == "J" or cardValue:sub(1, 1) == "Q" or cardValue:sub(1, 1) == "K" then
			value = value + 10
		else
			value = value + tonumber(cardValue:sub(1, 2))
		end
	end
	while value > 21 and aces > 0 do
		value = value - 10
		aces = aces - 1
	end
	return value
end

function displayPlayerCards()
	local playerCardPosX = 1
	for i = 1, #playerHand, 1 do
		playerCardPosX = i * 10 + 1
		paintutils.drawImage(cards[playerHand[i]], playerCardPosX, 20)
		term.setBackgroundColor(colors.green)
	end
	
end

function displayHouseCards()
	local houseCardPosX = 1
	if(#houseHand == 1) then
		houseCardPosX = 15
		paintutils.drawImage(cardBack, houseCardPosX, 2)
		term.setBackgroundColor(colors.green)
	else
		for i = 1, #houseHand, 1 do
			houseCardPosX = i * 10 + 1
			paintutils.drawImage(cards[houseHand[i]], houseCardPosX, 2)
			term.setBackgroundColor(colors.green)
		end
	end
end

-- EXECTUION

houseValue = 0
playerValue = 0

playerBet = 0

generateDeck()

shuffleDeck()

term.setBackgroundColor(colors.green)
term.clear()

-- MAIN LOOP
while true do
	print("How much would you like to bet: ")
	playerBet = io.read("*n")
	if playerBet == 0 then
		break
	end
	print("Enter any key to continue")
	io.read()
	term.clear()
	print("=======================")
	print("PLAYER's TURN")
	table.insert(playerHand, dealCard())
	table.insert(houseHand, dealCard())
	displayPlayerCards()
	print("=======================")
	print("HOUSE's TURN")
	displayHouseCards()
	print("Enter any key to continue")
	io.read()
	term.clear()
	print("=======================")
	print("PLAYER's TURN")
	table.insert(playerHand, dealCard())
	displayPlayerCards()
	playerValue = getHandValue(playerHand)
	print(playerValue)
	print("=======================")
	print("HOUSE's TURN")
	table.insert(houseHand, dealCard())
	print("####### of ######")
	paintutils.drawImage(cardBack, 1 * 10 + 1, 2)
	term.setBackgroundColor(colors.green)
	paintutils.drawImage(cards[houseHand[2]], 2 * 10 + 1, 2)
	term.setBackgroundColor(colors.green)
	print("Enter any key to continue")
	io.read()
	term.clear()
	print("=======================")
	print("PLAYER's TURN")
	displayPlayerCards()
	if(playerValue == 21) then
		print("BLACKJACK!")
		print("PLAYER WINS")
	end
	while playerValue < 21 do
		print("Hit or Stand?")
		local playerChoice = io.read()
		if playerChoice == "Hit" then
			print("Enter any key to continue")
			io.read()
			term.clear()
			print("=======================")
			print("PLAYER's TURN")
			table.insert(playerHand, dealCard())
			displayPlayerCards()
			playerValue = getHandValue(playerHand)
			if playerValue > 21 then
				break
			end
			print(playerValue)
		elseif playerChoice == "Stand" then
			break
		end
		playerChoice = ""
	end
	if(playerValue > 21) then
		print("PLAYER BUSTS")
		print("HOUSE WINS")
	end
	if playerValue < 21 then
		print("=======================")
		print("HOUSE's TURN")
		displayHouseCards()
		houseValue = getHandValue(houseHand)
		if(houseValue == 21) then
			print("BLACKJACK!")
			print("HOUSE WINS")
		end
		while houseValue < 17 do
			table.insert(houseHand, dealCard())
			term.clear()
			print("=======================")
			print("PLAYER's TURN")
			displayPlayerCards()
			print("=======================")
			print("HOUSE's TURN")
			displayHouseCards()
			houseValue = getHandValue(houseHand)
			print(houseValue)

		end
		if(houseValue > 21) then
			print("HOUSE BUSTS")
			print("PLAYER WINS")
		end
		if(playerValue > houseValue and playerValue <= 21) then
			print("PLAYER WINS")
		elseif(houseValue > playerValue and houseValue <= 21) then
			print("HOUSE WINS")
		elseif(playerValue == houseValue) then
			print("PUSH")
		end
	end
	playerHand = {}
	houseHand = {}

end

-- Player enters bet
-- Player gets one face up card
	-- Player's hand is evalutaed
-- Dealer gets one face down card
	-- Dealer's hand is evaluated
-- Player gets one face up card
	-- Player's hand is evaluated
-- Dealer gets one face up card
	-- Dealer's hand is evaluated

-- Player can hit or stand until bust or stand
	-- Player's hand is evaluated
--Is dealer's hand less than 17?
	-- Dealer hits
	-- Dealer's hand is evaluated
-- Is dealer's hand greater than 21?
	-- Player wins
-- Is player's hand greater than dealer's hand?
	-- Player wins
-- Is player's hand less than dealer's hand?
	-- Dealer wins
-- Is player's hand equal to dealer's hand?
	-- Push




