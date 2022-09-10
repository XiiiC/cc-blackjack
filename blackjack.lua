-- Blackjack game


-- CONSTANTS


value = {"A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"}
suit = {"Clubs", "Diamonds", "Hearts", "Spades"}

deck = {}

-- FUNCTIONS

function generateDeck()
	for i = 1, 4 do
		for j = 1, 13 do
			table.insert(deck, value[j] .. " of " .. suit[i])
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
		if card:sub(1, 1) == "A" then
			value = value + 11
			aces = aces + 1
		elseif card:sub(1, 1) == "J" or card:sub(1, 1) == "Q" or card:sub(1, 1) == "K" then
			value = value + 10
		else
			value = value + tonumber(card:sub(1, 2))
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
		if card:sub(1, 1) == "A" then
			value = value + 11
			aces = aces + 1
		elseif card:sub(1, 1) == "J" or card:sub(1, 1) == "Q" or card:sub(1, 1) == "K" then
			value = value + 10
		else
			value = value + tonumber(card:sub(1, 2))
		end
	end
	while value > 21 and aces > 0 do
		value = value - 10
		aces = aces - 1
	end
	return value
end

-- EXECTUION

houseValue = 0
playerValue = 0

playerBet = 0

playerHand = {}
houseHand = {}

generateDeck()

shuffleDeck()


--MAIN LOOP
while true do
	playerBet = io.read("*n")
	if playerBet == 0 then
		break
	end
	print("=======================")
	print("PLAYER's TURN")
	table.insert(playerHand, dealCard())
	for i = 1, #(playerHand), 1 do
		print(playerHand[i])
	end
	table.insert(houseHand, dealCard())
	print("=======================")
	print("HOUSE's TURN")
	print("####### of ######")
	print("=======================")
	print("PLAYER's TURN")
	table.insert(playerHand, dealCard())
	for i = 1, #(playerHand), 1 do
		print(playerHand[i])
	end
	playerValue = getHandValue(playerHand)
	print(playerValue)
	print("=======================")
	print("HOUSE's TURN")
	table.insert(houseHand, dealCard())
	print("####### of ######")
	print(houseHand[2])
	houseValue = getHouseHandValue(houseHand)
	print(houseValue)
	print("=======================")
	print("PLAYER's TURN")
	if(playerValue == 21) then
		print("BLACKJACK!")
		print("PLAYER WINS")
	end
	while playerValue < 21 do
		print("Hit or Stand?")
		local playerChoice = io.read()
		if playerChoice == "Hit" then
			print("=======================")
			print("PLAYER's TURN")
			table.insert(playerHand, dealCard())
			for i = 1, #(playerHand), 1 do
				print(playerHand[i])
			end
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
		for i = 1, #(houseHand), 1 do
			print(houseHand[i])
		end
		houseValue = getHandValue(houseHand)
		if(houseValue == 21) then
			print("BLACKJACK!")
			print("HOUSE WINS")
		end
		while houseValue < 17 do
			table.insert(houseHand, dealCard())
			print("=======================")
			print("HOUSE's TURN")
			for i = 1, #(houseHand), 1 do
				print(houseHand[i])
			end
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




