
local M = {}

-- main vector
mainVec = {}

-- each algorithm index to draw the square
index = {1, 1, 1}

-- vector for each algorithm
bubbleVec = {}
selectionVec = {}
insertionVec = {}
-- x and y for each algorithm
bVar = {0, 1}
sVar = {1, 1}
iVar = {1, 1}

-- size of the table
vecSize = 40
-- square text alpha value
alphaII = 0
-- Only runs when playingAnimations is true
function sortingAnimation(x, algorithm)

	-- increase the alpha
	if alphaII < 255 then
		alphaII = alphaII + 2
	end
	
	-- graph base
	love.graphics.setColor(0, 0, 0, alphaII)	
	love.graphics.rectangle("fill", x + 10, 350, 200, 5)
	
	-- drawing bars for every algorithm selected
	if algorithm == 1 then
		drawBars(bubbleVec, index[1], x)
		bubbleSort(bubbleVec, 1)
	elseif algorithm == 2 then
		drawBars(selectionVec, index[2], x)
		selectionSort(selectionVec, 2)
	elseif algorithm == 3 then
		drawBars(insertionVec, index[3], x)
		insertionSort(insertionVec, 3)
	end
	
	
end

-- drawing one bar for each value in the vector	
function drawBars(vector, index, x)
	for i = 1, #vector do
		love.graphics.setColor(100, 0, 0, alphaII)
		love.graphics.rectangle("fill", x + 5 + i * 5, 350 - vector[i] * 2, 3, 2 + vector[i] * 2)
	end
	
	-- draw red square to show which number is being compared
	love.graphics.setColor(255, 0, 0, alphaII)
	love.graphics.rectangle("fill", x + 5 + index * 5, 360, 5, 5)
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
	else
	-- creating a decreasing vec
		mainVec[1] = 50
		for i = 2, vecSize do
			mainVec[i] = mainVec[i - 1] - math.random(0, 3)
			
			if(mainVec[i] < 0) then
				mainVec[i] = 0
			end
		end
	end
	
	-- when the main vect is full, his value will be passed for the other ones
	for i = 1, 50 do
		bubbleVec[i] = mainVec[i]
		selectionVec[i] = mainVec[i]
		insertionVec[i] = mainVec[i]
	end
end


-- This function is using ifs and elses so it can change only one position at time, so the user can see what is going on in the vector

-- bubble sort function
function bubbleSort (vec, ind)
	
	-- bVar[2] is equal to y and bVar[1] to x. 

	if bVar[2] < #vec - 1 - (bVar[1]) then
		bVar[2] = bVar[2] + 1
	elseif bVar[1] < #vec then
		bVar[2] = 1
		bVar[1] = bVar[1] + 1
	else
		finishedAnimation = true
	end
	
	if vec[bVar[2]] > vec[bVar[2]+1] and bVar[2] < #vec then
		index[ind] = bVar[2]
							
		bTemp = vec[bVar[2]+1]
		vec[bVar[2]+1] = vec[bVar[2]]
		vec[bVar[2]] = bTemp
	end	
end

-- selection sort
function selectionSort (vec, ind)
	
	if sVar[2] == 1 then
		sVar[2] = sVar[1] + 1
	end
	
	if mi == nil then
		mi = sVar[1]
	end
	
	if sVar[2] < #vec then -- inside for
		sVar[2] = sVar[2] + 1
	elseif sVar[1] < #vec - 1 then -- outside for
		sVar[1] = sVar[1] + 1
		mi = sVar[1]
		sVar[2] = sVar[1] + 1
	else
		finishedAnimation = true
	end
	
	index[ind] = sVar[2]
	
	if vec[sVar[2]] < vec[mi] then -- finding the min in the inside for
		mi = sVar[2]
	end
		
	if sVar[2] == #vec and playingAnimations then -- doing after the inside for is over
		if sVar[1] ~= mi then
			sTemp = vec[sVar[1]]
			vec[sVar[1]] = vec[mi]
			vec[mi] = sTemp
		end
	end
end

-- insertion sort
function insertionSort (vec, ind)
	
	-- starting vars
	if iTemp == nil then
		
		iVar[1] = 2
		iVar[2] = iVar[1] - 1
		iTemp = vec[iVar[1]]
		
	end
	
	if iVar[2] >= 1 and vec[iVar[2]] > iTemp then -- inside while loop
		vec[iVar[2] + 1] = vec[iVar[2]]
		iVar[2] = iVar[2] - 1
		
		index[ind] = iVar[2]
		
	else
		vec[iVar[2] + 1] = iTemp
		
		if iVar[1] < #vec then -- outside loop
			
			iVar[1] = iVar[1] + 1
			iVar[2] = iVar[1] - 1
			iTemp = vec[iVar[1]]
		else
			finishedAnimation = true
		end
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
		sVar[i] = 1
		iVar[i] = 1
	end
	
	-- reset the alpha
	alphaII = 0
		
	-- reset animations triggers
	playingAnimations = false
	finishedAnimation = false


end

-- declaring to use in another lua file
M.testFunction = testFunction
M.sortingAnimation = sortingAnimation
M.fillVect = fillVect
M.reset = reset
	
return M