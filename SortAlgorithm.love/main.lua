--[[ 

Sorting Algorithm Animation - showing with graphs how sorting algorithms works
Using Love2D engine for games

	this version do not contain every algorithm - only : bubble sort
by GusPassos]]--

name = "Sorting Algorithm Animation"
x
--getting the screen size
width = love.graphics.getWidth()
height = love.graphics.getHeight()

-- loading another lua file
local sortingAlgorithms = require("sortingAlgorithms")

--[[
	0 = menu
	1 = choosing algorithm
]]--
screenIndex = 0

-- how te vector will be randomized
vectorType = 1

-- if the animation is beeing played
playingAnimations = false

-- selected algorithms titles alpha
alpha = 255

-- algorithms in this program
algorithm = {"Bubble Sort", "x", "x", "x", "x", "x", "x", "x", "x"}

-- which one is already selected
algorithmSelected = {false, false, false,
					false, false, false,
					false, false, false}
					

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
	if screenIndex == 0 then
		drawFirstScreen()
	elseif screenIndex == 1 then
		drawAnimationScreen()
	end
	
	-- "click to reset"
	if finishedAnimation then
		clickToReset()
	end
	
end

-- click to reset tip
function clickToReset()
	-- back retangle
	love.graphics.setColor(0, 0, 0, 200)
	love.graphics.rectangle("fill", (width / 2) - 200, height / 2 - 20, 400, 20)
	
	-- text
	love.graphics.setColor(255, 255, 255)		love.graphics.setFont(madeByFont)
	love.graphics.printf("click to reset", (width / 2) - 200, height / 2 - 20, 400, "center")
end

-- if a mouse event happen, this will catch the mouse position and make the tests
function love.mousepressed(x, y, button)

	-- choose algorithm button
	if x > (width / 2) - 150 and x < (width / 2) + 150 and y > 310 and y < 370 then
		screenIndex = 1
		
	end
	
	if screenIndex == 1 and not playingAnimations then
		-- if any of the algorithms is choosen
		for i = 0, (#algorithm / 3) - 1 do
			for j = 0, (#algorithm / 3) - 1 do
				-- using selection buttons
				love.graphics.setColor(0, 0, 0)
				if x > 40 + i * 240 and x < 280 + i * 240 and y > 140 + j * 150 and y < 280 + j * 150 then
					algorithmSelected[(j + i * 3) + 1] = not algorithmSelected[(j + i * 3) + 1]
				end
			end
		end -- end for
	end
	
	-- select all button
	if x > 50 and x < 150 and y > 45 and y < 80 then
		selectAll()
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

-- this screen has a border that changes color when the mouse moves, a button that starts the program and
-- a subtle animation that occours when the mouse moves - This animation is the actual sorting process, but with
-- a different style
function drawFirstScreen()
	
	-- back rect with color change related to mouse position	
	love.graphics.setColor(x / 3, 0, y / 3)
	love.graphics.rectangle("line", 20, 20, width - 40, height - 40, 10, 10)

	-- title
	love.graphics.setColor(0, 0, 0)
	love.graphics.setFont(titleFont)
	love.graphics.printf(name, (width / 2) - (titleFont:getWidth(name) / 2), 150, 600, "center")

	-- button animation
	if x > (width / 2) - 150 and x < (width / 2) + 150 and y > 310 and y < 370 then
		love.graphics.setColor(0, 0, 0)
		love.graphics.rectangle("line", (width / 2) - 150, 310, 300, 60, 10, 10)
	end
	
	-- draw button
	love.graphics.setColor(200, 200, 200)
	love.graphics.rectangle("fill", (width / 2) - 150, 310, 300, 60, 10, 10)
	
	-- button text
	love.graphics.setFont(buttonFont)
	love.graphics.setColor(255, 255, 255)
	love.graphics.printf("Choose Algorithms", (width / 2) - 220, 315, 440, "center")

	
	-- made by rect
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("fill", width - 125, height - 30, 150, 150)
	
	-- made by text
	love.graphics.setColor(0, 0, 0)
	love.graphics.setFont(madeByFont)
	love.graphics.printf("by: Gus Passos", width - 220, height - 30, 300, "center")
		
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
	
	for i = 0, (#algorithm / 3) - 1 do
		for j = 0, (#algorithm / 3) - 1 do
			
			-- animation
			love.graphics.setColor(0, 0, 0)
			if x > 40 + i * 240 and x < 280 + i * 240 and y > 140 + j * 150 and y < 280 + j * 150 then
				love.graphics.rectangle("line", 40 + i * 240, 140 + j * 150, 230, 140, 2, 2)
			end
			
			-- show which algorithm is selected
			if algorithmSelected[(j + i * 3) + 1] == true then
				love.graphics.rectangle("line", 40 + i * 240, 140 + j * 150, 230, 140, 2, 2)
			end
			
			-- rect where the title and the graph will be
			love.graphics.setColor(200, 200, 200)
			love.graphics.rectangle("fill", 40 + i * 240, 140 + j * 150, 230, 140, 2, 2)
			
			-- if the animation is beginning, the title will lost the alpha value and the vector representation will be drawn on the square
			if playingAnimations and algorithmSelected[(j + i * 3) + 1] then
			
				-- drawing vector representation and making the actual animation for each sorting algorithm selected
				sortingAlgorithms.sortingAnimation(40 + i * 240, 140 + j * 150, (j + i * 3) + 1)
				
				-- setting the new alpha
				love.graphics.setColor(255, 255, 255, alpha)
			else
				love.graphics.setColor(255, 255, 255)
			end
			
			-- algorithm name
			love.graphics.printf(algorithm[(j + i * 3) + 1], 40 + i * 240, 180 + j * 150, 230, "center")
	
		end
	end
end

-- alternates every option state to the oposite in the animation screen
function selectAll()
	for i = 1, #algorithmSelected do
		algorithmSelected[i] = not algorithmSelected[i]
	end
end