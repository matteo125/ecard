class EcardController < ApplicationController

	def new
		@ecard = Ecard.new
	end

	def create
	    @ecard = Ecard.new(
	    	params[:ecard][:lang],
	    	params[:ecard][:title], 
	    	params[:ecard][:pre_header], 
	    	params[:ecard][:width])
	end

	def show
		@ecard = Ecard.all
	end


	def download
		#I18n.locale = params[:lang]
		content = "<title>#{params[:title]}</title><body><h1>#{params[:title]}#{params[:lang]}</h1></body>"
		send_data content, type: "plain/text", filename: "ecard#{params[:lang]}.html"
	end

end