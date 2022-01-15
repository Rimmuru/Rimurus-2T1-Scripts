
--Shader Stuffs
function drawRect(x, y, width, height, colour)
	ui.draw_rect(x, y, width, height, colour.r, colour.g, colour.b, colour.a)
end

function drawOutline(title, scale, x, y, w, h, colour, fillColour, filled)
	filled = filled or false
	title = title or ""

	local white = {r=255, g=255, b=255, a=255}
	
	if(filled) then
		drawRect(x, y+h/2, w, h, fillColour)
	end
	
	ui.set_text_color(white.r, white.g, white.b, white.a)
	ui.set_text_font(1)
	ui.set_text_scale(scale, scale)
	ui.set_text_outline(scale)
	ui.set_text_centre(true)
	ui.draw_text(title, v2(x, y))
	
	drawRect(x, y, w, 0.003, colour)
	drawRect(x-w/2, y+h/2, 0.003, h,colour)
	drawRect(x+w/2, y+h/2, 0.003, h, colour)
	drawRect(x, y+h, w, 0.003, colour) 
end

--Text Stuffs
function drawText(text, x, y, font, scale, center, alignRight)
	local white = {r=255, g=255, b=255, a=255}

	ui.set_text_color(white.r, white.g, white.b, white.a)
	ui.set_text_font(font)
	ui.set_text_scale(scale, scale)
	ui.set_text_outline(1)

		if center then
			ui.set_text_centre(true)
		elseif alignRight then
			ui.set_text_right_justify(true)
		end
	
	ui.draw_text(text, v2(x, y))
end

--Menu Functions
function drawToggle(text, x, y, scale, bool)
	local white = {r=255, g=255, b=255, a=255}

	if bool then
	drawRect(x -0.05, y + 0.013, 0.01, 0.015, white)
		--	drawOutline("", 0, x - 0.05, y, 0.010, 0.010, white, white, true)
	else
		drawOutline("", 0, x - 0.05, y, 0.010, 0.010, white, white, false)
	end
	drawText(text, x, y, 1, scale, true, false)
end