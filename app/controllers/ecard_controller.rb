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

	    @content = data
		    @content.gsub!("titolo", params[:ecard][:title])

		    if params[:ecard][:pre_header_sel] == 'No'
		    @content.gsub!("#pre_header_yes_1", "<!--")
		    @content.gsub!("#pre_header_yes_2", "-->")
			end

			@content.gsub!("pre_header", params[:ecard][:pre_header])
		    @content.gsub!("img_width", params[:ecard][:width])
		    @content.gsub!("img_height", params[:ecard][:height])
		    @content.gsub!("#src", params[:ecard][:src])

		    if params[:ecard][:link_sel] == 'No'
		    @content.gsub!("#link_no_1", "<!--")
		    @content.gsub!("#link_no_2", "-->")
			end

		    @content.gsub!("link", params[:ecard][:link])
		    @content.gsub!("#alt", params[:ecard][:alt])

		    if params[:ecard][:forward_sel] == 'No'
		    @content.gsub!("#forward_no_1", "<!--")
		    @content.gsub!("#forward_no_2", "-->")
			end

		    #@content.gsub!("Forward", params[:ecard][:lang])
		#DOWNLOAD
		send_data @content, type: "plain/text", filename: "ecard-#{params[:ecard][:brand]}-#{params[:ecard][:lang]}.html"
	end

	def show
	    @content
	end


	def download
		#I18n.locale = params[:lang]
		#data = File.load Rails.root.join 'config/template/ecard_template.html'

		#content = "<title>#{params[:title]}</title><body><h1>#{params[:title]}#{params[:lang]}</h1></body>"
		send_data @content, type: "plain/text", filename: "ecard#{params[:ecard][:lang]}.html"
	end

end