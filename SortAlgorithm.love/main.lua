--[[ 

Sorting Algorithm Animation - showing with graphs how sorting algorithms works
+Using Love2D engine for games


by GusPassos

]]--

name = "Sorting Algorithm Animation"

--getting the screen size
width = love.graphics.getWidth()
height = love.graphics.getHeight()

-- loading another lua file
local sortingAlgorithms = require("sortingAlgorithms")

-- how te vector will be randomized
vectorType = 1
vecTypeName = {"Random", "Decreasing"}

-- if the animation is beeing played
playingAnimations = false

-- selected algorithms titles alpha
alpha = 255

-- algorithms in this program
algorithm = {"Bubble Sort", "Selection Sort", "Insertion Sort"}

-- which one is already selected
algorithmSelected = {false, false, false}
					

-- if every coroutine is ended
finishedAnimation = false

function love.load()
	
	-- initializing fonts
	titleFont = love.graphics.newFont("Fonts/Poly-Regular.ttf", 45)
	buttonFont = love.graphics.newFont("Fonts/Poly-Regular.ttf", 35)
	madeByFont = love.graphics.newFont("Fonts/Poly-Regular.ttf", 15)
	selectAllFont = love.graphics.newFont("Fonts/Poly-Regular.ttf", 20)
	
	-- setting background color
	love.graphics.setBackgroundColor(255, 255, 255)
	
end

-- dt = delta time
function love.update(dt)
	-- getting the mouse position
	x, y = love.mouse.getPosition()
end

-- drawing on the screen
function love.draw()
	
	drawAnimationScreen()
	
	-- "click to reset"
	if finishedAnimation then
		clickToReset()
	end
	
end

-- click to reset tip
function clickToReset()
	-- back retangle
	love.graphics.setColor(0, 0, 0, 200)
	love.graphics.rectangle("fill", (width / 2) - 200, height / 2 + 100, 400, 20)
	
	-- text
	love.graphics.setColor(255, 255, 255)		love.graphics.setFont(madeByFont)
	love.graphics.printf("click to reset", (width / 2) - 200, height / 2 + 100, 400, "center")
end

-- if a mouse event happen, this will catch the mouse position and make the tests
function love.mousepressed(x, y, button)
	
	
	-- if any algorithm is choosen
	if not playingAnimations then
		for i = 0, #algorithm - 1 do
			love.graphics.setColor(0, 0, 0)
			if x > 40 + i * 250 and x < 260 + i * 250 and y > (height/2) - 75 and y < (height/2) + 75 then
				algorithmSelected[i] = not algorithmSelected[i]
			end
		end
	end
	
	-- select all button
	if x > 50 and x < 150 and y > 45 and y < 80 then
		selectAll()
	end
	
	-- select vect type button
	if x > (width / 2) - 100 and x < (width / 2) + 100 and y > 90 and y < 120 then
		if vectorType == 2 then
			vectorType = 1
		elseif vectorType == 1 then
			vectorType = 2
		end
	end
	
	-- play button
	if x > width - 150 and x < width - 50 and y > 45 and y < 80 and not playingAnimations then 
		sortingAlgorithms.fillVect(vectorType)
		playingAnimations = true
	end
	
	if finishedAnimation then
		sortingAlgorithms.reset()
	end
	
end

-- this shows 9 sorting algorithms, selecting one of those and pressing the play button will start the animation showing how the vector is being reorganized by this algorithm
--It's possible to chose more than one algorithm and types of vectors
function drawAnimationScreen()
	
	-- drawing title
	love.graphics.setColor(0, 0, 0)
	love.graphics.setFont(titleFont)
	love.graphics.printf("Choose Algorithm", (width / 2) - (titleFont:getWidth("Choose Algorithm")), 30, 700, "center")
	
	-- select all button animation
	if x > 50 and x < 150 and y > 45 and y < 80 then
		love.graphics.setColor(0, 0, 0)
		love.graphics.rectangle("line", 50, 45, 100, 35, 15, 15)
	end
	
	-- select all button
	love.graphics.setColor(200, 200, 200)
	love.graphics.rectangle("fill", 50, 45, 100, 35, 15, 15)
	
	-- select all text
	love.graphics.setColor(255, 255, 255)
	love.graphics.setFont(selectAllFont)
	love.graphics.printf("select all", 60, 50, 200)
	
	-- play button animation
	if x > width - 150 and x < width - 50 and y > 45 and y < 80 then
		love.graphics.setColor(0, 0, 0)
		love.graphics.rectangle("line", width - 150, 45, 100, 35, 15, 15)
	end
	
	-- play button
	love.graphics.setColor(200, 200, 200)
	love.graphics.rectangle("fill", width - 150, 45, 100, 35, 15, 15)
	
	-- play text
	love.graphics.setColor(255, 255, 255)
	love.graphics.setFont(selectAllFont)
	love.graphics.printf("play", width - 125, 50, 200)
	
	-- select vector type
	love.graphics.setColor(200, 200, 200)
	love.graphics.rectangle("fill", (width / 2) - 100, 90, 200, 30, 15, 15)
	
	-- select vector type text
	love.graphics.setColor(0, 0, 0)
	love.graphics.printf("vector type:", (width / 2) - 225, 90, 500)
	
	-- vector type animation
	if x > (width / 2) - 100 and x < (width / 2) + 100 and y > 90 and y < 120 then
		love.graphics.setColor(0, 0, 0)
		love.graphics.rectangle("line", (width / 2) - 100, 90, 200, 30, 15, 15)
	end
	
	-- show vector type selected
	love.graphics.printf(vecTypeName[vectorType], ((width / 2) - 100) + 100 - selectAllFont:getWidth(vecTypeName[vectorType]) / 2, 90, 400)
	
	-- drawing options
	drawOptions()
	
end

-- draw every option of sorting algorithm in the screen
function drawOptions()

	-- decreasing/increasing alpha from algorithms selected
	if playingAnimations and alpha > 0 then
		alpha = alpha - 5
	elseif alpha < 255 then
		alpha = alpha + 5
	end
	
	-- algorithms title font 
	love.graphics.setFont(buttonFont)
	
	for i = 0, #algorithm - 1 do
		--animation
		love.graphics.setColor(0, 0, 0)
		if x > 40 + i * 250 and x < 260 + i * 250 and y > (height/2) - 75 and y < (height/2) + 75 then
			love.graphics.rectangle("line", 40 + i * 250, (height/2) - 75, 220, 150, 15, 15)
		end
		
		-- show which algorithm is selected
		if algorithmSelected[i] == true then
			love.graphics.rectangle("line", 40 + i * 250, (height/2) - 75, 220, 150, 15, 15)
		end
		
		-- square for each algorithm
		love.graphics.setColor(200, 200, 200)
		love.graphics.rectangle("fill", 40 + i * 250, (height/2) - 75, 220, 150, 15, 15)
		
		-- if the animation is beginning, the title will lost the alpha value and the vector representation will be drawn on the square
		if playingAnimations and algorithmSelected[i] then
		
			-- drawing vector representation and making the actual animation for each sorting algorithm selected
			sortingAlgorithms.sortingAnimation(40 + i * 250, i+1)
			
			--setting the new alpha
			love.graphics.setColor(255, 255, 255, alpha)
		else
			love.graphics.setColor(255, 255, 255)
		end
		
		-- algorithm name
		love.graphics.printf(algorithm[i+1], 40 + i * 250 - 90, (height/2) - 25, 400, "center")
	end
end

-- alternates every option state to the oposite in the animation screen
function selectAll()
	for i = 1, #algorithmSelected do
		algorithmSelected[i] = not algorithmSelected[i]
	end
end