
pastelGreen = {r=167, g=244, b=163, a=255}
white = {r=255, g=255, b=255, a=255}
black = {r=0, g=0, b=0, a=150}
blue = {r=137, g=196, b=244, a=255}

LuaUI = { 
	Options = { 
		 scroll = 0,
		 maxScroll = 0,
		 menuWH = v2(),
		 menuPos = v2()
		},
		currentMenu,
		menus = {}
}

--Shader Stuffs
function LuaUI.drawRect(x, y, width, height, colour)
	ui.draw_rect(x, y, width, height, colour.r, colour.g, colour.b, colour.a)
end

function LuaUI.drawOutline(title, scale, x, y, w, h, colour, fillColour, filled)
	filled = filled or false
	title = title or ""

	if(filled) then
		LuaUI.drawRect(x, y+h/2, w, h, fillColour)
	end
	
	ui.set_text_color(white.r, white.g, white.b, white.a)
	ui.set_text_font(1)
	ui.set_text_scale(scale, scale)
	ui.set_text_outline(scale)
	ui.set_text_centre(true)
	ui.draw_text(title, v2(x, y))
	
	LuaUI.drawRect(x, y, w, 0.003, colour)
	LuaUI.drawRect(x-w/2, y+h/2, 0.003, h,colour)
	LuaUI.drawRect(x+w/2, y+h/2, 0.003, h, colour)
	LuaUI.drawRect(x, y+h, w, 0.003, colour) 
	LuaUI.drawRect(x, y + 0.026, w, 0.003, colour)
end

--Text Stuffs
function LuaUI.drawText(text, x, y, font, scale, center, alignRight)
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
function LuaUI.drawOption(text, num)
    LuaUI.drawText(text, LuaUI.Options.menuPos.x, LuaUI.Options.menuPos.y + 0.035 + (0.34 * num/10), 1, 0.5, true, false)
end

function LuaUI.drawOptionToggle(text, num, toggle)
	LuaUI.drawText(tostring(toggle and 'on' or "off"), LuaUI.Options.menuPos.x + 0.06, LuaUI.Options.menuPos.y + 0.035 + (0.34 * num/10) + 0.005, 0, 0.3, true, false)
	LuaUI.drawText(text, LuaUI.Options.menuPos.x, LuaUI.Options.menuPos.y + 0.035 + (0.34 * num/10), 1, 0.5, true, false)
end

function LuaUI.drawSubmenu(text, x, y, scale)
	LuaUI.drawText(text, x, y, 1, scale, true, false)
	LuaUI.drawText(">>", x + 0.05, y, 1, scale, true, false)
end

function LuaUI.switchToSub(sub)
	LuaUI.Options.currentMenu = LuaUI.Options.menus[sub]
end
