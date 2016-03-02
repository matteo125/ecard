class EcardController < ApplicationController

	def new
		@ecard = Ecard.new
	end

	def create
	    @ecard = Ecard.new(
	    	params[:ecard][:lang],
	    	params[:ecard][:title], 
	    	params[:ecard][:pre_header], 
	    	params[:ecard][:width],
	    	params[:ecard][:height],
	    	params[:ecard][:src],
	    	params[:ecard][:link],
	    	params[:ecard][:alt],
	    	params[:ecard][:forward])

	    data = File.read("config/template/ecard_template.html")
	    @content = data
		    @content = @content.gsub("titolo", params[:ecard][:title])
		    @content = @content.gsub("pre_header", params[:ecard][:pre_header])
		    @content = @content.gsub("img_width", params[:ecard][:width])
		    @content = @content.gsub("img_height", params[:ecard][:height])
		    @content = @content.gsub("#src", params[:ecard][:src])
		    @content = @content.gsub("link", params[:ecard][:link])
		    @content = @content.gsub("#alt", params[:ecard][:alt])
		    @content = @content.gsub("forward", params[:ecard][:forward])
	end

	def show
	    @content
	end


	def download
		#I18n.locale = params[:lang]
		#data = File.load Rails.root.join 'config/template/ecard_template.html'
		@content
		#content = "<title>#{params[:title]}</title><body><h1>#{params[:title]}#{params[:lang]}</h1></body>"
		send_data @content, type: "plain/text", filename: "ecard#{params[:lang]}.html"
	end

end