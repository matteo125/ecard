class EcardController < ApplicationController

	def new
		@ecard = Ecard.new
	end

	def create
	    @ecard = Ecard.new(
	    	params[:ecard][:brand],
	    	params[:ecard][:lang],
	    	params[:ecard][:title], 
	    	params[:ecard][:pre_header],
	    	params[:ecard][:pre_header_sel], 
	    	params[:ecard][:width],
	    	params[:ecard][:height],
	    	params[:ecard][:src],
	    	params[:ecard][:link],
	    	params[:ecard][:alt],
	    	params[:ecard][:forward])

#SCELTA BRAND
	    if params[:ecard][:brand] == 'MiuMiu'
	    	data = File.read("config/template/ecard_template_miumiu.html")
	    else
	    	data = File.read("config/template/ecard_template_prada.html")
		end

#DATI
	    @content = data
		    @content.gsub!("titolo", params[:ecard][:title])

		    if params[:ecard][:pre_header_sel] == 'No'
			    @content.gsub!("#p_h_yes_1", "<!--")
			    @content.gsub!("#p_h_yes_2", "-->")
			else
				@content.gsub!("#p_h_yes_1", "")
			    @content.gsub!("#p_h_yes_2", "")
			end

			@content.gsub!("pre_header", params[:ecard][:pre_header])
		    @content.gsub!("img_width", params[:ecard][:width])
		    @content.gsub!("img_height", params[:ecard][:height])
		    @content.gsub!("#src", params[:ecard][:src])

		    if params[:ecard][:link_sel] == 'No'
			    @content.gsub!("#l_no_1", "<!--")
			    @content.gsub!("#l_no_2", "-->")
			else
				@content.gsub!("#l_no_1", "")
			    @content.gsub!("#l_no_2", "")
			end

		    @content.gsub!("link", params[:ecard][:link])
		    @content.gsub!("#alt", params[:ecard][:alt])

		    if params[:ecard][:forward_sel] == 'No'
			    @content.gsub!("#f_no_1", "<!--")
			    @content.gsub!("#f_no_2", "-->")
			else
				@content.gsub!("#f_no_1", "")
			    @content.gsub!("#f_no_2", "")	
			end

#TRADUZIONI
		require 'yaml'
		
#prada
		if params[:ecard][:brand] == "Prada"
			translate = YAML.load_file("config/locales/translate_prada.yml")
			brand = "PRADA"
		else
			translate = YAML.load_file("config/locales/translate_miumiu.yml")
			brand = "MIU MIU"
		end
		
		@content.gsub!("If you have trouble seeing this e-mail please ", translate[params[:ecard][:lang]]["browser_view_1"])
		@content.gsub!("click here</a> to unsubscribe. <br />", translate[params[:ecard][:lang]]["footer_3"])
		@content.gsub!("click here", translate[params[:ecard][:lang]]["browser_view_2"])
		@content.gsub!("To ensure that our communications are safely received in your inbox,<br/>please add ", translate[params[:ecard][:lang]]["footer_1"])
		@content.gsub!("to your address book.", translate[params[:ecard][:lang]]["footer_1_2"])
		@content.gsub!("Forward to a friend", translate[params[:ecard][:lang]]["forward"])
		@content.gsub!("We legitimately collected your e-mail address in circumstances such as in stores or through the web site,<br />when you knowingly provided this information. We make our best effort in order to handle such information<br />in conformity with privacy regulations and in complete safety. Please ", translate[params[:ecard][:lang]]["footer_2"])
		@content.gsub!("Click here</a> for information related to #{brand} company and legal information.", translate[params[:ecard][:lang]]["legal_informations"])


#DOWNLOAD
		send_data @content, type: "plain/text", filename: "ecard-#{params[:ecard][:brand]}-#{params[:ecard][:lang]}.html"
	end

	def show
	    @content
	end


	def download
		send_data @content, type: "plain/text", filename: "ecard#{params[:ecard][:lang]}.html"
	end

end