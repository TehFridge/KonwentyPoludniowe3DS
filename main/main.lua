-- main.lua
require "lib.text-draw"
font =  love.graphics.newFont(12, "normal", 4) 
local json = require("lib.json")
local https = require("https")
local ltn12 = require("ltn12")
local htmlparser = require("htmlparser")
local logo = love.graphics.newImage("assets/logo.png")
local bg = love.graphics.newImage("assets/bg.png")
local bgx = -120
local bgy = -180
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
	BASE_PARAGRAPH_POS = 50
	ADD_PARAGRAPH_POS = 15
	ART_TITLE = 1.35
	ART_CONTEXTKURWANWM = 1.1
	BASE_GAP = 35
	RECTANGLE_HEIGHT = 32
	REC_GAP = 0
	CONLST_GAP = 20
	CONLST_BASE = 80
	CONLST_NAME_S = 1.4
	CONLST_NAME_DUNNO = 0
	BG_S = 0.5
	player_speed = 140
elseif love._console == "Switch" then
	SCREEN_WIDTH = 1280
	SCREEN_HEIGHT = 720
	LOGO_SCALE = 0.9
	LOGO_TEXT_OFFSET = 130
	HEADLINE_SCALE = 3
	PARAGRAPH_SCALE = 2.2
	BASE_PARAGRAPH_POS = 80
	ADD_PARAGRAPH_POS = 30
	ART_TITLE = 2
	ART_CONTEXTKURWANWM = 1.8
	BASE_GAP = 100
	RECTANGLE_HEIGHT = 95
	REC_GAP = 8
	CONLST_GAP = 70
	CONLST_BASE = 130
	CONLST_NAME_S = 2.5
	CONLST_NAME_DUNNO = 20
	BG_S = 1.5
	player_speed = 140
end

function love.load()	
	--font = love.graphics.newFont("anyfont.otf", 8)
	MOVE_PAGE = -20
	kurwacoto_jest = 1
	mode_sel = 1
	additional_offset = 1
	state = "title_screen"
	rel_offset = 0
	selection = 1
	conurl = 1
	conselection = 1
	refresh_data("https://konwenty-poludniowe.pl")
	REFRESHED = 1
end
function draw_top_screen(dt)
	DrawRectangle(0, SCREEN_WIDTH, {0.06, 0.06, 0.06, 1}, SCREEN_HEIGHT, true)
	love.graphics.draw(bg, bgx, bgy, 0, BG_S, BG_S)
	if state == "lista_kon" then
		--love.graphics.print(tree, 10, 10)
		--love.graphics.print(header2, 10, 20)
		TextDraw.DrawTextCentered("Nadchodzące Wydarzenia", SCREEN_WIDTH/2, 40, {1, 1, 1, 1}, font, HEADLINE_SCALE)
		if conselection == 1 then
			DrawRectangle(CONLST_BASE, SCREEN_WIDTH, {0.35, 0.35, 0.35, 1}, CONLST_GAP * 0.97, false, 5)
			TextDraw.DrawTextCentered(con1, SCREEN_WIDTH/2, CONLST_BASE + CONLST_NAME_DUNNO, {0.28, 0.22, 0.34, 1}, font, CONLST_NAME_S)
		else
			DrawRectangle(CONLST_BASE, SCREEN_WIDTH, {0.14, 0.14, 0.14, 1}, CONLST_GAP * 0.97, false, 5)
			TextDraw.DrawTextCentered(con1, SCREEN_WIDTH/2, CONLST_BASE + CONLST_NAME_DUNNO, {0.72, 0.63, 0.81, 1}, font, CONLST_NAME_S)
		end
		if conselection == 2 then
			DrawRectangle(CONLST_BASE + CONLST_GAP, SCREEN_WIDTH, {0.35, 0.35, 0.35, 1}, CONLST_GAP * 0.97, false, 5)
			TextDraw.DrawTextCentered(con2, SCREEN_WIDTH/2, CONLST_BASE + CONLST_NAME_DUNNO + CONLST_GAP, {0.28, 0.22, 0.34, 1}, font, CONLST_NAME_S)
		else	
			DrawRectangle(CONLST_BASE + CONLST_GAP, SCREEN_WIDTH, {0.14, 0.14, 0.14, 1}, CONLST_GAP * 0.97, false, 5)
			TextDraw.DrawTextCentered(con2, SCREEN_WIDTH/2, CONLST_BASE + CONLST_NAME_DUNNO + CONLST_GAP, {0.72, 0.63, 0.81, 1}, font, CONLST_NAME_S)
		end
		if conselection == 3 then
			DrawRectangle(CONLST_BASE + CONLST_GAP * 2, SCREEN_WIDTH, {0.35, 0.35, 0.35, 1}, CONLST_GAP * 0.97, false, 5)
			TextDraw.DrawTextCentered(con3, SCREEN_WIDTH/2, CONLST_BASE + CONLST_NAME_DUNNO + CONLST_GAP * 2,{0.28, 0.22, 0.34, 1}, font, CONLST_NAME_S)
		else
			DrawRectangle(CONLST_BASE + CONLST_GAP * 2, SCREEN_WIDTH, {0.14, 0.14, 0.14, 1}, CONLST_GAP * 0.97, false, 5)
			TextDraw.DrawTextCentered(con3, SCREEN_WIDTH/2, CONLST_BASE + CONLST_NAME_DUNNO + CONLST_GAP * 2, {0.72, 0.63, 0.81, 1}, font, CONLST_NAME_S)
		end
		if conselection == 4 then
			DrawRectangle(CONLST_BASE + CONLST_GAP * 3, SCREEN_WIDTH, {0.35, 0.35, 0.35, 1}, CONLST_GAP * 0.97, false, 5)
			TextDraw.DrawTextCentered(con4, SCREEN_WIDTH/2, CONLST_BASE + CONLST_NAME_DUNNO + CONLST_GAP * 3, {0.28, 0.22, 0.34, 1}, font, CONLST_NAME_S)
		else
			DrawRectangle(CONLST_BASE + CONLST_GAP * 3, SCREEN_WIDTH, {0.14, 0.14, 0.14, 1}, CONLST_GAP * 0.97, false, 5)
		    TextDraw.DrawTextCentered(con4, SCREEN_WIDTH/2, CONLST_BASE + CONLST_NAME_DUNNO + CONLST_GAP * 3, {0.72, 0.63, 0.81, 1}, font, CONLST_NAME_S)
		end
		if conselection == 5 then
			DrawRectangle(CONLST_BASE + CONLST_GAP * 4, SCREEN_WIDTH, {0.35, 0.35, 0.35, 1}, CONLST_GAP * 0.97, false, 5)
			TextDraw.DrawTextCentered(con5, SCREEN_WIDTH/2, CONLST_BASE + CONLST_NAME_DUNNO + CONLST_GAP * 4, {0.28, 0.22, 0.34, 1}, font, CONLST_NAME_S)
		else
			DrawRectangle(CONLST_BASE + CONLST_GAP * 4, SCREEN_WIDTH, {0.14, 0.14, 0.14, 1}, CONLST_GAP * 0.97, false, 5)
			TextDraw.DrawTextCentered(con5, SCREEN_WIDTH/2, CONLST_BASE + CONLST_NAME_DUNNO + CONLST_GAP * 4, {0.72, 0.63, 0.81, 1}, font, CONLST_NAME_S)
	    end
		if conselection == 6 then
			DrawRectangle(CONLST_BASE + CONLST_GAP * 5, SCREEN_WIDTH, {0.35, 0.35, 0.35, 1}, CONLST_GAP * 0.97, false, 5)
			TextDraw.DrawTextCentered(con6, SCREEN_WIDTH/2, CONLST_BASE + CONLST_NAME_DUNNO + CONLST_GAP * 5, {0.28, 0.22, 0.34, 1}, font, CONLST_NAME_S)
		else
			DrawRectangle(CONLST_BASE + CONLST_GAP * 5, SCREEN_WIDTH, {0.14, 0.14, 0.14, 1}, CONLST_GAP * 0.97, false, 5)
		    TextDraw.DrawTextCentered(con6, SCREEN_WIDTH/2, CONLST_BASE + CONLST_NAME_DUNNO + CONLST_GAP * 5, {0.72, 0.63, 0.81, 1}, font, CONLST_NAME_S)
		end
		if conselection == 7 then
			DrawRectangle(CONLST_BASE + CONLST_GAP * 6, SCREEN_WIDTH, {0.35, 0.35, 0.35, 1}, CONLST_GAP * 0.97, false, 5)
			TextDraw.DrawTextCentered(con7, SCREEN_WIDTH/2, CONLST_BASE + CONLST_NAME_DUNNO + CONLST_GAP * 6, {0.28, 0.22, 0.34, 1}, font, CONLST_NAME_S)
		else
			DrawRectangle(CONLST_BASE + CONLST_GAP * 6, SCREEN_WIDTH, {0.14, 0.14, 0.14, 1}, CONLST_GAP * 0.97, false, 5)
			TextDraw.DrawTextCentered(con7, SCREEN_WIDTH/2, CONLST_BASE + CONLST_NAME_DUNNO + CONLST_GAP * 6, {0.72, 0.63, 0.81, 1}, font, CONLST_NAME_S)
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
			draw_widget(news1, BASE_PARAGRAPH_POS + 45 - REC_GAP, true)
		else
			draw_widget(news1, BASE_PARAGRAPH_POS + 45 - REC_GAP, false)
		end
		TextDraw.DrawTextCentered(date1, SCREEN_WIDTH/2, BASE_PARAGRAPH_POS + 45 + ADD_PARAGRAPH_POS, {0.72, 0.63, 0.81, 1}, font, PARAGRAPH_SCALE)
		if kurwacoto_jest == 2 then
			draw_widget(news2, BASE_PARAGRAPH_POS + 45 + BASE_GAP - REC_GAP, true)
		else
			draw_widget(news2, BASE_PARAGRAPH_POS + 45 + BASE_GAP - REC_GAP, false)
		end
		TextDraw.DrawTextCentered(date2, SCREEN_WIDTH/2, BASE_PARAGRAPH_POS + 45 + ADD_PARAGRAPH_POS + BASE_GAP, {0.72, 0.63, 0.81, 1}, font, PARAGRAPH_SCALE)
		if kurwacoto_jest == 3 then
			draw_widget(news3, BASE_PARAGRAPH_POS + 45 + (BASE_GAP * 2) - REC_GAP, true)
		else
			draw_widget(news3, BASE_PARAGRAPH_POS + 45 + (BASE_GAP * 2) - REC_GAP, false)
		end
		TextDraw.DrawTextCentered(date3, SCREEN_WIDTH/2, BASE_PARAGRAPH_POS + 45 + ADD_PARAGRAPH_POS + (BASE_GAP * 2), {0.72, 0.63, 0.81, 1}, font, PARAGRAPH_SCALE)
	elseif state == "relacje" then
		--TextDraw.DrawTextCentered(parseurl(tree("h2")[1]:gettext()), SCREEN_WIDTH/2, 40, {1, 1, 1, 1}, font, 1) 
		TextDraw.DrawTextCentered("Relacje z Konwentów", SCREEN_WIDTH/2, 40, {1, 1, 1, 1}, font, HEADLINE_SCALE)
		if kurwacoto_jest == 1 then
			draw_widget(rel1, BASE_PARAGRAPH_POS + 45 - REC_GAP, true)
		else
			draw_widget(rel1, BASE_PARAGRAPH_POS + 45 - REC_GAP, false)
		end
		TextDraw.DrawTextCentered(date1, SCREEN_WIDTH/2, BASE_PARAGRAPH_POS + 45 + ADD_PARAGRAPH_POS, {0.72, 0.63, 0.81, 1}, font, PARAGRAPH_SCALE)
		if kurwacoto_jest == 2 then
			draw_widget(rel2, BASE_PARAGRAPH_POS + 45 + BASE_GAP - REC_GAP, true)
		else
			draw_widget(rel2, BASE_PARAGRAPH_POS + 45 + BASE_GAP - REC_GAP, false)
		end
		TextDraw.DrawTextCentered(date2, SCREEN_WIDTH/2, BASE_PARAGRAPH_POS + 45 + ADD_PARAGRAPH_POS + BASE_GAP, {0.72, 0.63, 0.81, 1}, font, PARAGRAPH_SCALE)
		if kurwacoto_jest == 3 then
			draw_widget(rel3, BASE_PARAGRAPH_POS + 45 + (BASE_GAP * 2) - REC_GAP, true)
		else
			draw_widget(rel3, BASE_PARAGRAPH_POS + 45 + (BASE_GAP * 2) - REC_GAP, false)
		end
		TextDraw.DrawTextCentered(date3, SCREEN_WIDTH/2, BASE_PARAGRAPH_POS + 45 + ADD_PARAGRAPH_POS + (BASE_GAP * 2), {0.72, 0.63, 0.81, 1}, font, PARAGRAPH_SCALE)
	elseif state == "article" then
		if MOVE_PAGE >= -36 then
			DrawRectangle(-20, SCREEN_WIDTH + 10, {0.26, 0.14, 0.31, 1}, (TextDraw.GetTextHeight(pagetitle, font, 1.3) * 4.3), false, 0)
			TextDraw.DrawTextCentered(pagetitle, SCREEN_WIDTH/2, 10, {1, 1, 1, 1}, font, ART_TITLE)
		end
		TextDraw.DrawText(ART_PARS, 0, BASE_PARAGRAPH_POS + MOVE_PAGE, {1, 1, 1, 1}, font, ART_CONTEXTKURWANWM)
		if testimage ~= nil then
			love.graphics.draw(testimage, 0, BASE_PARAGRAPH_POS + MOVE_PAGE + 29 * newline_count, 0, 1.2, 1.2)
		end

	elseif state == "con_info" then
		TextDraw.DrawTextCentered(tree("#event-hdr")[1]:getcontent(), SCREEN_WIDTH/2, 40 * ART_TITLE, {1, 1, 1, 1}, font, ART_TITLE)
		TextDraw.DrawTextCentered(tree("#conv-date")[1]:getcontent(), SCREEN_WIDTH/2, 80 * ART_CONTEXTKURWANWM, {1, 1, 1, 1}, font, ART_CONTEXTKURWANWM)
		TextDraw.DrawTextCentered(tree("#conv-address")[1]:getcontent(), SCREEN_WIDTH/2, 100 * ART_CONTEXTKURWANWM, {1, 1, 1, 1}, font, ART_CONTEXTKURWANWM)
		TextDraw.DrawTextCentered("Opis:", SCREEN_WIDTH/2, 130 * ART_CONTEXTKURWANWM, {1, 1, 1, 1}, font, ART_CONTEXTKURWANWM)
		TextDraw.DrawTextCentered(TextDraw.GetWrappedText(cut_eventdesc, font, SCREEN_WIDTH, ART_CONTEXTKURWANWM), SCREEN_WIDTH/2, 150 * ART_CONTEXTKURWANWM, {1, 1, 1, 1}, font, ART_CONTEXTKURWANWM)
		--TextDraw.DrawTextCentered(tree("p")[3]:getcontent(), SCREEN_WIDTH/2, 150, {1, 1, 1, 1}, font, 1)
	elseif state == "con_desc" then
		TextDraw.DrawTextCentered(TextDraw.GetWrappedText(event_desc, font, SCREEN_WIDTH, ART_CONTEXTKURWANWM), SCREEN_WIDTH/2, 10, {1, 1, 1, 1}, font, ART_CONTEXTKURWANWM)
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
	if mode_sel == 1 then 
		TextDraw.DrawTextCentered("B - Aktualności", 320/2, 60, {1, 1, 1, 1}, font, 1)
	elseif mode_sel == 2 then
		TextDraw.DrawTextCentered("B - Relacje z Konwentów (WiP)", 320/2, 60, {1, 1, 1, 1}, font, 1)
	end
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
	TextDraw.DrawTextCentered("Select - Aktualności/Relacje", 320/2, 140, {1, 1, 1, 1}, font, 1)
end
local function extract_p_tags(html)
    local paragraphs = {}
	if html:gmatch("<p>(.-)</p>") then
		for p in html:gmatch("<p>(.-)</p>") do
			table.insert(paragraphs, "<p>" .. p .. "</p>")
		end
	elseif html:gmatch("<p (.-)>(.-)</p>") then
		for p in html:gmatch("<p (.-)>(.-)</p>") do
			table.insert(paragraphs, "<p (.-)>" .. p .. "</p>")
		end
	end
    return table.concat(paragraphs, "\n")
end

-- Function to decode HTML entities
function decode_html_entities(str)
    -- Replace known HTML entities with their characters
    str = str:gsub("&quot;", "\"")
    str = str:gsub("&amp;", "&")
    str = str:gsub("&lt;", "<")
    str = str:gsub("&gt;", ">")
    str = str:gsub("&nbsp;", " ")  -- Convert nbsp to a regular space
    return str
end

-- Function to parse the article
function parsearticle(xml_to_parse)
    local str = xml_to_parse
    
    -- Step 1: Decode HTML entities
    str = decode_html_entities(str)
	--print(str)
    -- Step 2: Process the content
    local output = str
		:gsub('<div class="tags">.-</div>', "") 
        :gsub("<br%s*/?>", "\n")                -- Replace <br> tags with newlines
        :gsub("<noscript>", ""):gsub("</noscript>", "") -- Remove <noscript> tags
        :gsub("<a href=[^>]+>(.-)</a>", "%1")  -- Remove links but keep their text
        :gsub("<strong>(.-)</strong>", "%1")   -- Keep bolded content without tags
        :gsub("<li>", "- ")                     -- Handle <li> tags as list items (with a dash)
        :gsub("</li>", "\n")                    -- Replace closing </li> tag with a newline
        :gsub("<ul>", "\n")                     -- Start unordered list with a newline (optional)
        :gsub("</ul>", "\n")                    -- End unordered list with a newline (optional)
        :gsub("<p>", "\n")                      -- Replace <p> with newline
        :gsub("</p>", "\n")                     -- Replace </p> with newline
        :gsub("<.->", "")                      -- Remove any other remaining tags
        :gsub("\r", "")                        -- Remove carriage returns (optional, depends on source)
        :gsub("\n%s*\n", "\n\n")               -- Clean up extra newlines
        :gsub("^%s+", "")                      -- Trim leading whitespace
        :gsub("%s+$", "")                      -- Trim trailing whitespace
		:gsub("Facebook Social Comments", "")
	print("https://konwenty-poludniowe.pl" .. string.match(tree(".content img[data-src]")[1]:gettext(), 'data%-src="([^"]+)"'))
	if state == "main_strona" then
		downloadimage("https://konwenty-poludniowe.pl/" .. string.match(tree(".content img[data-src]")[1]:gettext(), 'data%-src="([^"]+)"'))
	end
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
function downloadimage(url)
	if love._console == "3DS" then
		local data = json.encode({url = url})
		refresh_data("https://api.szprink.xyz/t3x/convert", data, {["api-version"] = "4.4", ["application-id"] = "%C5%BCappka", ["user-agent"] = "Synerise Android SDK 5.9.0 pl.zabka.apb2c", ["accept"] = "application/json", ["mobile-info"] = "horizon;28;AW700000000;9;CTR-001;nintendo;5.9.0", ["content-type"] = "application/json"}, "POST")
		local imageData = love.image.newImageData(love.filesystem.newFileData(image, "image.t3x"))
		testimage = love.graphics.newImage(imageData)
	else
		refresh_data(url, "", {}, "GET")
		local imageData = love.image.newImageData(love.filesystem.newFileData(image, "image.png"))
		testimage = love.graphics.newImage(imageData)
	end
end
function gotopage(reference)
	refresh_data("https://konwenty-poludniowe.pl" .. reference)
end

function refresh_data(url)
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
	if string.match(url, "jpg") then
		image = body
	else
		-- Your HTML string to parse
		local html = body

		-- Parse the HTML
		tree = htmlparser.parse(html)
	end
	
end
function loadarticle()
	MOVE_PAGE = -20
	pagetitle = TextDraw.GetWrappedText((tree(".page-header h1 a")[1]:getcontent()), font, SCREEN_WIDTH, 1.3)
	--love.filesystem.write("chuj.txt", parsearticle(tree(".content")[1]:getcontent()))
	ART_PARS = TextDraw.GetWrappedText(parsearticle(tree(".content")[1]:getcontent()), font, SCREEN_WIDTH, ART_CONTEXTKURWANWM)
	local function count_newlines(text)
		local _, newline_count = text:gsub("\n", "") -- Match all `\n` and count them
		return newline_count
	end
	newline_count = count_newlines(ART_PARS)
	print(ART_PARS:gsub("\n", "\\n"))
end
function update_re_re_kurwa_jak_jest_relacja_po_angielsku()
	rel1 = limitchar(tree(".page-header h2 a")[additional_offset]:getcontent())
	date1 = tree(".published")[additional_offset]:getcontent()
	rel2 = limitchar(tree(".page-header h2 a")[additional_offset + 1]:getcontent())
	date2 = tree(".published")[additional_offset + 1]:getcontent()
	rel3 = limitchar(tree(".page-header h2 a")[additional_offset + 2]:getcontent())
	date3 = tree(".published")[additional_offset + 2]:getcontent()
end
function limitchar(str)
	if str:len() > 79 then
		return string.sub(str, 1, 79) .. "..."
	else
		return str
	end
end
function update_news()
	news1 = limitchar(tree(".item-title a")[additional_offset]:getcontent())
	date1 = tree(".published")[additional_offset]:getcontent()
	news2 = limitchar(tree(".item-title a")[additional_offset + 1]:getcontent())
	date2 = tree(".published")[additional_offset + 1]:getcontent()
	news3 = limitchar(tree(".item-title a")[additional_offset + 2]:getcontent())
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
	print(state)
	if button == "b" then
		if mode_sel == 1 then 
			refresh_data("https://konwenty-poludniowe.pl")
			REFRESHED = 1
			update_news()
			state = "main_strona"
		else
			refresh_data("https://konwenty-poludniowe.pl/konwenty/relacje-z-konwentow?start=" .. rel_offset)
			REFRESHED = 1
			update_re_re_kurwa_jak_jest_relacja_po_angielsku()
			state = "relacje"
		end
	end
	if button == "y" then
		if REFRESHED == 0 then
			refresh_data("https://konwenty-poludniowe.pl/konwenty/kalendarz")
			REFRESHED = 1
		end
		print(bgx .. " " .. bgy)
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
			elseif state == "relacje" then
				if selection < 9 then
					selection = selection + 1 
					if kurwacoto_jest > 2 then
						kurwacoto_jest = 1
						additional_offset = additional_offset + 3
						update_re_re_kurwa_jak_jest_relacja_po_angielsku()
					else
						kurwacoto_jest = kurwacoto_jest + 1
					end
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
			
		    elseif state == "relacje" then
				if selection > 1 then
					selection = selection - 1 
					if kurwacoto_jest < 2 then
						selection = selection - 2
						additional_offset = additional_offset - 3
						update_re_re_kurwa_jak_jest_relacja_po_angielsku()
						kurwacoto_jest = 1
					else
						kurwacoto_jest = kurwacoto_jest - 1
					end
				end
			end
		end
		if button == "a" then
			if state == "main_strona" then	
				gotopage(parseurl(tree(".item-title a")[selection]:gettext()))
				REFRESHED = 1
				loadarticle() 
				state = "article"
			elseif state == "lista_kon" then
				gotopage(parseurl(tree("#upcoming_events li")[conurl]:gettext()))
				REFRESHED = 1
				if string.match(tree(".content")[1]:getcontent(), "event_description") then
					cut_eventdesc = tree(".event_description p")[1]:getcontent()
					event_desc = parsearticle(tree(".event_description")[1]:getcontent())
				else 
					cut_eventdesc = "Brak Opisu"
					event_desc = "Brak Opisu"
				end
				state = "con_info"
			elseif state == "relacje" then
				gotopage(parseurl(tree(".page-header h2 a")[selection]:gettext()))
				REFRESHED = 1
				loadarticle()
				state = "article"
			end
		end
		if button == "x" then
			if state == "con_info" then
				state = "con_desc"
			end
		end
		if state == "relacje" then
			if button == "leftshoulder" then
				if additional_offset ~= 0 then
					rel_offset = rel_offset - 9
					refresh_data("https://konwenty-poludniowe.pl/konwenty/relacje-z-konwentow?start=" .. rel_offset)
					update_re_re_kurwa_jak_jest_relacja_po_angielsku()
				end
			elseif button == "rightshoulder" then
				rel_offset = rel_offset + 9
				refresh_data("https://konwenty-poludniowe.pl/konwenty/relacje-z-konwentow?start=" .. rel_offset)
				update_re_re_kurwa_jak_jest_relacja_po_angielsku()
			end
		end
		if button == "start" then
			love.event.quit()
		end
		if button == "back" then 
			if mode_sel > 1 then
				mode_sel = 1
			else
				mode_sel = mode_sel + 1
			end
		end
	end
end


function love.update(dt)
	if bgy <= 0 then
		bgx = bgx + 0.255
		bgy = bgy + 0.3 
	else
		bgx = -120
		bgy = -180
	end
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
		if love._potion_version == nil then
			if love.keyboard.isDown("up") then
				MOVE_PAGE = MOVE_PAGE + player_speed * dt
			end
			if love.keyboard.isDown("down") then
				MOVE_PAGE = MOVE_PAGE - player_speed * dt
			end
		end
	end
    love.graphics.origin()  
end

