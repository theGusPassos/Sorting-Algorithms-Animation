
local M = {}

-- main vector
mainVec = {}

-- check if all animations are being played


-- each algorithm index to draw the square
index = {1, 1, 1, 1, 1, 1, 1, 1, 1}

-- vector where bubble sort will be applied
bubbleVec = {}
-- x and y from bubble sort
bVar = {1, 1}

-- size of the table
vecSize = 35
-- square text alpha value
alphaII = 0
-- Only runs when playingAnimations is true
function sortingAnimation(x, y, algorithm)

	-- increase the alpha
	if alphaII < 255 then
		alphaII = alphaII + 2
	end
	
	-- graph base
	love.graphics.setColor(0, 0, 0, alphaII)
	love.graphics.rectangle("fill", x + 10, y + 110, 210, 5)
	
	-- drawing bars for every algorithm selected
	if algorithm == 1 then
		drawBars(bubbleVec, index[1], x, y)
		bubbleSort(bubbleVec, 1)
	end
	
end

-- drawing one bar for each value in the vector	
function drawBars(vector, index, x, y)
	for i = 1, #vector do
		love.graphics.setColor(100, 0, 0, alphaII)
		love.graphics.rectangle("fill", x + 5 + i * 6, y + 110 - vector[i] * 2, 5, 2 + vector[i] * 2)
	end
	
	-- draw red square to show which number is being compared
	love.graphics.setColor(255, 0, 0, alphaII)
	love.graphics.rectangle("fill", x + 5 + index * 6, y + 120, 5, 5)
end

-- fill the vect with random numbers 
function fillVect(sortType)
	-- reseting random
	math.randomseed(os.time())
	
	-- random from 0 to 50
	if sortType == 1 then
		for i = 1, vecSize do
			mainVec[i] = math.random(0, 50)
		end
	end
	
	-- when the main vect is full, his value will be passed for the other ones
	bubbleVec = mainVec
end

-- bubble sort function
-- This function is using ifs and elses so it can change only one position at time, so the user can see what is going on in the vector
function bubbleSort (vec, ind)
	
	-- bVar[2] is equal to y and bVar[1] to x. 

	if bVar[2] < #vec - (bVar[1] + 1) + 1 then
		bVar[2] = bVar[2] + 1
	elseif bVar[1] < #vec - 1 then
		bVar[2] = 1
		bVar[1] = bVar[1] + 1
	else
		-- when reach this, the loop is finished
		finishedAnimation = true
	end
	
	if vec[bVar[2]] > vec[bVar[2]+1] then
		index[ind] = bVar[2]
							
		temp = vec[bVar[2]+1]
		vec[bVar[2]+1] = vec[bVar[2]]
		vec[bVar[2]] = temp
	end	
	
end
	

-- reset every var from this file
function reset()

	-- reset the index for every sorting algorithm and reset which one is being selected	
	for i = 1, #index do
		index[i] = 1
		algorithmSelected[i] = false
	end

	-- reset every var from the algorithm loop
	for i = 1, 2 do
		bVar[i] = 1
	end
	
	-- reset the alpha
	alphaII = 0
	
	-- reset animations triggers
	playingAnimations = false
	-- one because is the only one working right now - FX
	finishedAnimation = false
	
end

-- declaring to use in another lua file
M.testFunction = testFunction
M.sortingAnimation = sortingAnimation
M.fillVect = fillVect
M.reset = reset
	
return M