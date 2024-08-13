-- main.lua
require "lib.text-draw"
local https = require("https")
local ltn12 = require("ltn12")
local htmlparser = require("htmlparser")
local logo = love.graphics.newImage("assets/logo.png")
if love._potion_version == nil then
	local nest = require("nest").init({ console = "3ds", scale = 1 })
	love._nest = true
    love._console_name = "3DS"
end
state = nil
if love._console == "3DS" then
	SCREEN_WIDTH = 400
	SCREEN_HEIGHT = 240
	LOGO_SCALE = 0.4
	LOGO_TEXT_OFFSET = 70
	HEADLINE_SCALE = 2.1
	PARAGRAPH_SCALE = 0.9
	BASE_PARAGRAPH_POS = 80
	ADD_PARAGRAPH_POS = 15
	BASE_GAP = 35
	RECTANGLE_HEIGHT = 32
	REC_GAP = 0
	player_speed = 25
elseif love._console == "Switch" then
	SCREEN_WIDTH = 1280
	SCREEN_HEIGHT = 720
	LOGO_SCALE = 0.9
	LOGO_TEXT_OFFSET = 130
	HEADLINE_SCALE = 3
	PARAGRAPH_SCALE = 2.2
	BASE_PARAGRAPH_POS = 130
	ADD_PARAGRAPH_POS = 30
	BASE_GAP = 100
	RECTANGLE_HEIGHT = 95
	REC_GAP = 8
end

function love.load()	
	--font = love.graphics.newFont("anyfont.otf", 8)
	MOVE_PAGE = -20
	kurwacoto_jest = 1
	additional_offset = 1
	state = "title_screen"
	selection = 1
	conurl = 1
	conselection = 1
end
function draw_top_screen(dt)
	DrawRectangle(0, SCREEN_WIDTH, {0.06, 0.06, 0.06, 1}, SCREEN_HEIGHT, true)
	if state == "lista_kon" then
		--love.graphics.print(tree, 10, 10)
		--love.graphics.print(header2, 10, 20)
		TextDraw.DrawTextCentered("Nadchodzące Wydarzenia", SCREEN_WIDTH/2, 40, {1, 1, 1, 1}, font, 2.1)
		if conselection == 1 then
			DrawRectangle(80, SCREEN_WIDTH, {0.35, 0.35, 0.35, 1}, 20.5, false, 5)
			TextDraw.DrawTextCentered(con1, SCREEN_WIDTH/2, 80, {0.28, 0.22, 0.34, 1}, font, 1.4)
		else
			DrawRectangle(80, SCREEN_WIDTH, {0.14, 0.14, 0.14, 1}, 20.5, false, 5)
			TextDraw.DrawTextCentered(con1, SCREEN_WIDTH/2, 80, {0.72, 0.63, 0.81, 1}, font, 1.4)
		end
		if conselection == 2 then
			DrawRectangle(100, SCREEN_WIDTH, {0.35, 0.35, 0.35, 1}, 20.5, false, 5)
			TextDraw.DrawTextCentered(con2, SCREEN_WIDTH/2, 100, {0.28, 0.22, 0.34, 1}, font, 1.4)
		else	
			DrawRectangle(100, SCREEN_WIDTH, {0.14, 0.14, 0.14, 1}, 20.5, false, 5)
			TextDraw.DrawTextCentered(con2, SCREEN_WIDTH/2, 100, {0.72, 0.63, 0.81, 1}, font, 1.4)
		end
		if conselection == 3 then
			DrawRectangle(120, SCREEN_WIDTH, {0.35, 0.35, 0.35, 1}, 20.5, false, 5)
			TextDraw.DrawTextCentered(con3, SCREEN_WIDTH/2, 120,{0.28, 0.22, 0.34, 1}, font, 1.4)
		else
			DrawRectangle(120, SCREEN_WIDTH, {0.14, 0.14, 0.14, 1}, 20.5, false, 5)
			TextDraw.DrawTextCentered(con3, SCREEN_WIDTH/2, 120, {0.72, 0.63, 0.81, 1}, font, 1.4)
		end
		if conselection == 4 then
			DrawRectangle(140, SCREEN_WIDTH, {0.35, 0.35, 0.35, 1}, 20.5, false, 5)
			TextDraw.DrawTextCentered(con4, SCREEN_WIDTH/2, 140, {0.28, 0.22, 0.34, 1}, font, 1.4)
		else
			DrawRectangle(140, SCREEN_WIDTH, {0.14, 0.14, 0.14, 1}, 20.5, false, 5)
		    TextDraw.DrawTextCentered(con4, SCREEN_WIDTH/2, 140, {0.72, 0.63, 0.81, 1}, font, 1.4)
		end
		if conselection == 5 then
			DrawRectangle(160, SCREEN_WIDTH, {0.35, 0.35, 0.35, 1}, 20.5, false, 5)
			TextDraw.DrawTextCentered(con5, SCREEN_WIDTH/2, 160, {0.28, 0.22, 0.34, 1}, font, 1.4)
		else
			DrawRectangle(160, SCREEN_WIDTH, {0.14, 0.14, 0.14, 1}, 20.5, false, 5)
			TextDraw.DrawTextCentered(con5, SCREEN_WIDTH/2, 160, {0.72, 0.63, 0.81, 1}, font, 1.4)
	    end
		if conselection == 6 then
			DrawRectangle(180, SCREEN_WIDTH, {0.35, 0.35, 0.35, 1}, 20.5, false, 5)
			TextDraw.DrawTextCentered(con6, SCREEN_WIDTH/2, 180, {0.28, 0.22, 0.34, 1}, font, 1.4)
		else
			DrawRectangle(180, SCREEN_WIDTH, {0.14, 0.14, 0.14, 1}, 20.5, false, 5)
		    TextDraw.DrawTextCentered(con6, SCREEN_WIDTH/2, 180, {0.72, 0.63, 0.81, 1}, font, 1.4)
		end
		if conselection == 7 then
			DrawRectangle(200, SCREEN_WIDTH, {0.35, 0.35, 0.35, 1}, 20.5, false, 5)
			TextDraw.DrawTextCentered(con7, SCREEN_WIDTH/2, 200, {0.28, 0.22, 0.34, 1}, font, 1.4)
		else
			DrawRectangle(200, SCREEN_WIDTH, {0.14, 0.14, 0.14, 1}, 20.5, false, 5)
			TextDraw.DrawTextCentered(con7, SCREEN_WIDTH/2, 200, {0.72, 0.63, 0.81, 1}, font, 1.4)
		end
		--love.graphics.print("Check console for parsed output.", 10, 10)
	elseif state == "title_screen" then
		DrawImageCentered(logo, SCREEN_WIDTH/2, SCREEN_HEIGHT/2, LOGO_SCALE)
		TextDraw.DrawTextCentered("Konwenty Południowe " .. love._console, SCREEN_WIDTH/2, (SCREEN_HEIGHT / 2) + LOGO_TEXT_OFFSET, {1, 1, 1, 1}, font, 2.1)
	elseif state == "loading" then
		DrawKrynciol(SCREEN_WIDTH/2,SCREEN_HEIGHT/2)
		--TextDraw.DrawTextCentered("Ładowanie...", SCREEN_WIDTH/2, SCREEN_HEIGHT / 2, {1, 1, 1, 1}, font, 2.1)
	elseif state == "main_strona" then
		--TextDraw.DrawTextCentered(parseurl(tree("h2")[1]:gettext()), SCREEN_WIDTH/2, 40, {1, 1, 1, 1}, font, 1) 
		TextDraw.DrawTextCentered("Aktualności", SCREEN_WIDTH/2, 40, {1, 1, 1, 1}, font, HEADLINE_SCALE)
		if kurwacoto_jest == 1 then
			draw_widget(news1, BASE_PARAGRAPH_POS - REC_GAP, true)
		else
			draw_widget(news1, BASE_PARAGRAPH_POS - REC_GAP, false)
		end
		TextDraw.DrawTextCentered(date1, SCREEN_WIDTH/2, BASE_PARAGRAPH_POS + ADD_PARAGRAPH_POS, {0.72, 0.63, 0.81, 1}, font, PARAGRAPH_SCALE)
		if kurwacoto_jest == 2 then
			draw_widget(news2, BASE_PARAGRAPH_POS + BASE_GAP - REC_GAP, true)
		else
			draw_widget(news2, BASE_PARAGRAPH_POS + BASE_GAP - REC_GAP, false)
		end
		TextDraw.DrawTextCentered(date2, SCREEN_WIDTH/2, BASE_PARAGRAPH_POS + ADD_PARAGRAPH_POS + BASE_GAP, {0.72, 0.63, 0.81, 1}, font, PARAGRAPH_SCALE)
		if kurwacoto_jest == 3 then
			draw_widget(news3, BASE_PARAGRAPH_POS + (BASE_GAP * 2) - REC_GAP, true)
		else
			draw_widget(news3, BASE_PARAGRAPH_POS + (BASE_GAP * 2) - REC_GAP, false)
		end
		TextDraw.DrawTextCentered(date3, SCREEN_WIDTH/2, BASE_PARAGRAPH_POS + ADD_PARAGRAPH_POS + (BASE_GAP * 2), {0.72, 0.63, 0.81, 1}, font, PARAGRAPH_SCALE)
	elseif state == "article" then
		if MOVE_PAGE >= -24 then
			DrawRectangle(-20, SCREEN_WIDTH + 10, {0.26, 0.14, 0.31, 1}, (TextDraw.GetTextHeight(pagetitle, font, 1.3) * 4.3), false, 0)
			TextDraw.DrawTextCentered(pagetitle, SCREEN_WIDTH/2, 10, {1, 1, 1, 1}, font, 1.3)
		end
		TextDraw.DrawTextCentered(ART_PARS, SCREEN_WIDTH/2, BASE_PARAGRAPH_POS + MOVE_PAGE, {1, 1, 1, 1}, font, 1)
	elseif state == "con_info" then
		TextDraw.DrawTextCentered(tree("#event-hdr")[1]:getcontent(), SCREEN_WIDTH/2, 40, {1, 1, 1, 1}, font, 1.2)
		TextDraw.DrawTextCentered(tree("#conv-date")[1]:getcontent(), SCREEN_WIDTH/2, 80, {1, 1, 1, 1}, font, 1)
		TextDraw.DrawTextCentered(tree("#conv-address")[1]:getcontent(), SCREEN_WIDTH/2, 100, {1, 1, 1, 1}, font, 1)
		TextDraw.DrawTextCentered("Opis:", SCREEN_WIDTH/2, 130, {1, 1, 1, 1}, font, 1)
		TextDraw.DrawTextCentered(TextDraw.GetWrappedText(cut_eventdesc, font, SCREEN_WIDTH, 1), SCREEN_WIDTH/2, 150, {1, 1, 1, 1}, font, 1)
		--TextDraw.DrawTextCentered(tree("p")[3]:getcontent(), SCREEN_WIDTH/2, 150, {1, 1, 1, 1}, font, 1)
	elseif state == "con_desc" then
		TextDraw.DrawTextCentered(TextDraw.GetWrappedText(event_desc, font, SCREEN_WIDTH, 1), SCREEN_WIDTH/2, 10, {1, 1, 1, 1}, font, 1)
	end
end

function draw_widget(text, y, selected)
	if selected == true then
		DrawRectangle(y, SCREEN_WIDTH, {0.35, 0.35, 0.35, 1}, RECTANGLE_HEIGHT, false, 5)
		TextDraw.DrawTextCentered(text, SCREEN_WIDTH/2, y, {0.28, 0.22, 0.34, 1}, font, PARAGRAPH_SCALE)
	else
		DrawRectangle(y, SCREEN_WIDTH, {0.14, 0.14, 0.14, 1}, RECTANGLE_HEIGHT, false, 5)
		TextDraw.DrawTextCentered(text, SCREEN_WIDTH/2, y, {0.72, 0.63, 0.81, 1}, font, PARAGRAPH_SCALE)
	end
end
function draw_bottom_screen(dt)
	DrawRectangle(0, 400, {0.113,0.062,0.133, 1}, 240, true)
	TextDraw.DrawTextCentered("Y - Nadchodzące Konwenty", 320/2, 40, {1, 1, 1, 1}, font, 1)
	TextDraw.DrawTextCentered("B - Strona Główna", 320/2, 60, {1, 1, 1, 1}, font, 1)
	if state == "article" then
		TextDraw.DrawTextCentered("DPad Góra/Dół - Scrolluj treść", 320/2, 80, {1, 1, 1, 1}, font, 1)
	else 
		TextDraw.DrawTextCentered("DPad Góra/Dół - Wybór treści", 320/2, 80, {1, 1, 1, 1}, font, 1)
	end
	TextDraw.DrawTextCentered("A - Załaduj Treść", 320/2, 100, {1, 1, 1, 1}, font, 1)
	if state == "con_info" then
		TextDraw.DrawTextCentered("X - Załaduj Cały Opis", 320/2, 120, {1, 1, 1, 1}, font, 1)
	end
	TextDraw.DrawTextCentered("Start - Zamknij Aplikacje", 320/2, 200, {1, 1, 1, 1}, font, 1)
end
function parsearticle(xml_to_parse)
	local str = xml_to_parse
	
	local output = str:gsub("<br/>", ""):gsub("<p>", ""):gsub("</p>", " "):gsub("<", ""):gsub("strong", ""):gsub("a href=[^>]+", ""):gsub("&amp;", ""):gsub("%(", ""):gsub("%)", ""):gsub("&nbsp;", " "):gsub("/%a", ""):gsub("%a/", ""):gsub("/", ""):gsub(">", "")
	
	return output
end

function parseparagraphs(xml_to_parse)
	local str = xml_to_parse
	
	local output = str:gsub("<p>", ""):gsub("</p>", " ")
	
	return output
end
function parseurl(xml_to_parse)
	local str = xml_to_parse

	-- Use pattern matching to extract the URL path
	local url_path = str:match('href="(.-)"')
	return url_path
end

function gotopage(reference)
	refresh_data("https://konwenty-poludniowe.pl" .. reference)
end

function refresh_data(url)
	state = "loading"
    -- Headers
    -- local myheaders = {
        -- ["user-agent"] = "Mozilla/5.0 (Windows NT 10.0; rv:129.0) Gecko/20100101 Firefox/129.0",
        -- ["accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/png,image/svg+xml,*/*;q=0.8",
        -- ["sec-fetch-user"] = "?1",
		-- ["sec-fetch-site"] = "none",
        -- ["sec-fetch-mode"] = "navigate",
        -- ["sec-fetch-dest"] = "document",
        -- ["accept-encoding"] = "gzip, deflate, br, zstd",
        -- ["accept-language"] = " pl,en-US;q=0.7,en;q=0.3",
		-- ["upgrade-insecure-requests"] = "1",
		-- ["te"] = "trailers",
		-- ["content-length"] = "0",
        -- ["priority"] = "u=0, i"
    -- }
    -- Response table to collect the response body
    response_body = {}

    -- Making the HTTP request
    code, body, headers = https.request(url, {method = "get", headers = {} })
	
    -- Your HTML string to parse
    local html = body

    -- Parse the HTML
    tree = htmlparser.parse(html)
	
end
function loadarticle()
	pagetitle = TextDraw.GetWrappedText((tree(".page-header h1 a")[1]:getcontent()), font, SCREEN_WIDTH, 1.3)
	ART_PARS = TextDraw.GetWrappedText(parsearticle(tree(".content p")[1]:getcontent() .. " " .. tree("p")[3]:getcontent().. " " .. tree("p")[4]:getcontent()), font, SCREEN_WIDTH, 1)
end
function update_news()
	news1 = tree(".item-title a")[additional_offset]:getcontent()
	date1 = tree(".published")[additional_offset]:getcontent()
	news2 = tree(".item-title a")[additional_offset + 1]:getcontent()
	date2 = tree(".published")[additional_offset + 1]:getcontent()
	news3 = tree(".item-title a")[additional_offset + 2]:getcontent()
	date3 = tree(".published")[additional_offset + 2]:getcontent()
end		
function love.draw(screen)
    if screen == "bottom" then
        draw_bottom_screen()
    else
        draw_top_screen()
    end
end 

function love.gamepadpressed(joystick, button)
	if button == "b" then
		refresh_data("https://konwenty-poludniowe.pl")
		update_news()
		state = "main_strona"
	end
	if button == "y" then
		refresh_data("https://konwenty-poludniowe.pl/konwenty/kalendarz")
		--con1 = tree("#upcoming_events li a")[1]:getcontent()
		con1 = tree("#upcoming_events li a")[1]:getcontent()
		con2 = tree("#upcoming_events li a")[2]:getcontent()
		con3 = tree("#upcoming_events li a")[3]:getcontent()
		con4 = tree("#upcoming_events li a")[4]:getcontent()
		con5 = tree("#upcoming_events li a")[5]:getcontent()
		con6 = tree("#upcoming_events li a")[6]:getcontent()
		con7 = tree("#upcoming_events li a")[7]:getcontent()
		state = "lista_kon"
	end
	if state == "main_strona" or "lista_kon" then
		if button == "dpdown" then
			if state == "main_strona" then
				if selection < 6 then
					selection = selection + 1 
					if kurwacoto_jest > 2 then
						kurwacoto_jest = 1
						additional_offset = additional_offset + 3
						update_news()
					else
						kurwacoto_jest = kurwacoto_jest + 1
					end
				end
			elseif state == "lista_kon" then
				if conselection < 7 and conurl < 14 then
					conselection = conselection + 1
					conurl = conurl + 2
				end
			end
		elseif button == "dpup" then
		    if state == "main_strona" then
				if selection > 1 then
					selection = selection - 1 
					if kurwacoto_jest < 2 then
						selection = selection - 2
						additional_offset = additional_offset - 3
						update_news()
						kurwacoto_jest = 1
					else
						kurwacoto_jest = kurwacoto_jest - 1
					end
				end
			elseif state == "lista_kon" then
				if conselection > 1 and conurl > 1 then
					conselection = conselection - 1
					conurl = conurl - 2
				end
			end
		end
		if button == "a" then
			if state == "main_strona" then	
				gotopage(parseurl(tree(".item-title a")[selection]:gettext()))
				loadarticle()
				state = "article"
			elseif state == "lista_kon" then
				gotopage(parseurl(tree("#upcoming_events li")[conurl]:gettext()))
				cut_eventdesc = tree(".event_description p")[1]:getcontent()
				event_desc = parsearticle(tree(".event_description")[1]:getcontent())
				state = "con_info"
			end
		end
		if button == "x" then
			if state == "con_info" then
				state = "con_desc"
			end
		end
		if state == "main_strona" then
			if button == "leftshoulder" then
				if additional_offset ~= 0 then
					selection = selection - 3
					additional_offset = additional_offset - 3
					update_news()
				end
			elseif button == "rightshoulder" then
				selection = selection + 3
				additional_offset = additional_offset + 3
				update_news()
			end
		end
		if button == "start" then
			love.event.quit()
		end
	end
end


function love.update(dt)
	if state == "article" then
		local joystick = love.joystick.getJoysticks()[1]
		if joystick then 
			if joystick:isGamepadDown("dpup") then
				MOVE_PAGE = MOVE_PAGE + player_speed * dt
			end
			if joystick:isGamepadDown("dpdown") then
				MOVE_PAGE = MOVE_PAGE - player_speed * dt
			end
		end
	end
    love.graphics.origin()  
end

