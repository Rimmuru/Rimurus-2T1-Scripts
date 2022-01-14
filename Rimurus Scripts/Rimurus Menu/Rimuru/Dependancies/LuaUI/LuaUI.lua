
Colour = {
	pastelGreen = {r=167, g=244, b=163, a=255},
	white = {r=255, g=255, b=255, a=255},
	black = {r=0, g=0, b=0, a=150},
	blue = {r=137, g=196, b=244, a=255}
}

LuaUI = { 
	Options = { 
		 scroll = 0,
		 maxScroll = 0,
		 menuWH = v2(),
		 menuPos = v2(),
		 currentMenu = "",
		 menus = {}
		}
}

--Shader Stuffs
function LuaUI.drawRect(x, y, width, height, colour)
	ui.draw_rect(x, y, width, height, colour.r, colour.g, colour.b, colour.a)
end

function LuaUI.drawOutline(title, scale, x, y, w, h, borderColour, fillColour, filled, spliiter)
	filled = filled or false
	spliiter = spliiter or false
	title = title or ""

	if (filled) then
		LuaUI.drawRect(x, y+h/2, w, h, fillColour)
	end
	
	ui.set_text_color(Colour.white.r, Colour.white.g, Colour.white.b, Colour.white.a)
	ui.set_text_font(1)
	ui.set_text_scale(scale, scale)
	ui.set_text_outline(scale)
	ui.set_text_centre(true)
	ui.draw_text(tostring(title), v2(x, y))
	
	LuaUI.drawRect(x, y, w, 0.003, borderColour)
	LuaUI.drawRect(x-w/2, y+h/2, 0.003, h,borderColour)
	LuaUI.drawRect(x+w/2, y+h/2, 0.003, h, borderColour)
	LuaUI.drawRect(x, y+h, w, 0.003, borderColour) 

	if spliiter then
		LuaUI.drawRect(x, y + 0.026, w, 0.003, borderColour)
	end
end

local function RGBAToInt(R, G, B, A) --Borrowed from gif.lua
	A = A or 255
	return ((R&0x0ff)<<0x00)|((G&0x0ff)<<0x08)|((B&0x0ff)<<0x10)|((A&0x0ff)<<0x18)
end

local function logging(text)
	print(text)
	menu.notify(text)
end

local sprite
function LuaUI.setUpBanner(pathToBanner)
	local appdata = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\"
	if pathToBanner == nil then
		logging("Couldnt find path "..pathToBanner)
	else
		sprite = scriptdraw.register_sprite(appdata..pathToBanner)
	end
end

function LuaUI.drawBanner(x, y, borderColour)
	scriptdraw.draw_sprite(sprite, v2(x-0.50, y-0.03), 0.25, 0, RGBAToInt(Colour.white.r, Colour.white.g, Colour.white.b, Colour.white.a))

	LuaUI.drawOutline("", 0, x, y-0.07, LuaUI.Options.menuWH.x, 0.12, borderColour, borderColour, false, false)
end

--Text Stuffs
function LuaUI.drawText(text, x, y, font, scale, center, alignRight)
	ui.set_text_color(Colour.white.r, Colour.white.g, Colour.white.b, Colour.white.a)
	ui.set_text_font(font)
	ui.set_text_scale(scale, scale)
	ui.set_text_outline(1)

		if center then
			ui.set_text_centre(true)
		elseif alignRight then
			ui.set_text_right_justify(true)
		end
	
	ui.draw_text(tostring(text), v2(x, y))
end

--Menu Functions
function LuaUI.drawOption(text, num)
    LuaUI.drawText(tostring(text), LuaUI.Options.menuPos.x, LuaUI.Options.menuPos.y + 0.035 + (0.34 * num/10), 1, 0.5, true, false)
end

function LuaUI.drawOptionToggle(text, num, toggle)
	LuaUI.drawText(tostring(toggle and 'on' or "off"), LuaUI.Options.menuPos.x + 0.06, LuaUI.Options.menuPos.y + 0.035 + (0.34 * num/10) + 0.005, 0, 0.3, true, false)
	LuaUI.drawText(tostring(text), LuaUI.Options.menuPos.x, LuaUI.Options.menuPos.y + 0.035 + (0.34 * num/10), 1, 0.5, true, false)
end

function LuaUI.drawSubmenu(text, num)
	LuaUI.drawText(tostring(text), LuaUI.Options.menuPos.x, LuaUI.Options.menuPos.y + 0.035 + (0.34 * num/10), 1, 0.5, true, false)
	LuaUI.drawText(">>", LuaUI.Options.menuPos.x + 0.05, LuaUI.Options.menuPos.y + 0.032 + (0.34 * num/10) + 0.005, 1, 0.5, true, false)
end

function LuaUI.drawStringSlider(text, num, option, sliderValue)
	LuaUI.drawText("<"..tostring(option[sliderValue + 1])..">", LuaUI.Options.menuPos.x + 0.06, LuaUI.Options.menuPos.y + 0.035 + (0.34 * num/10) + 0.005, 0, 0.3, true, false)
	LuaUI.drawText(tostring(text), LuaUI.Options.menuPos.x, LuaUI.Options.menuPos.y + 0.035 + (0.34 * num/10), 1, 0.5, true, false)
end

function LuaUI.drawIntSlider(text, num, option)
	LuaUI.drawText("<"..tonumber(option)..">", LuaUI.Options.menuPos.x + 0.06, LuaUI.Options.menuPos.y + 0.035 + (0.34 * num/10) + 0.005, 0, 0.3, true, false)
	LuaUI.drawText(tostring(text), LuaUI.Options.menuPos.x, LuaUI.Options.menuPos.y + 0.035 + (0.34 * num/10), 1, 0.5, true, false)
end

function LuaUI.switchToSub(sub)
	LuaUI.Options.scroll = 0
	LuaUI.Options.currentMenu = LuaUI.Options.menus[sub]
end
