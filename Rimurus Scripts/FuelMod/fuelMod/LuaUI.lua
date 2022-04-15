Colour = {
	green = {r=5, g=245, b=50, a=255},
	white = {r=255, g=255, b=255, a=255},
	black = {r=0, g=0, b=0, a=150},
	blue = {r=137, g=196, b=244, a=255},
	orange = {r=243, g=156, b=18, a=255},
	orange2 = {r=255, g=128, b=0, a=255},
	red = {r=245, g=5, b=50, a=255}
}

LuaUI = {}

function LuaUI.RGBAToInt(R, G, B, A) --Borrowed from gif.lua
	A = A or 255
	return ((R&0x0ff)<<0x00)|((G&0x0ff)<<0x08)|((B&0x0ff)<<0x10)|((A&0x0ff)<<0x18)
end

--Shader Stuffs
function LuaUI.drawRect(x, y, width, height, colour)
	ui.draw_rect(x, y, width, height, colour.r, colour.g, colour.b, colour.a)
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
