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

	    data = File.read("config/template/ecard_template.html")
	    @content = data
	    @content = @content.gsub("Forward", params[:ecard][:title])
	end

	def show
	    
	end


	def download
		#I18n.locale = params[:lang]
		#data = File.load Rails.root.join 'config/template/ecard_template.html'

		#content = "<title>#{params[:title]}</title><body><h1>#{params[:title]}#{params[:lang]}</h1></body>"
		send_data @content, type: "plain/text", filename: "ecard#{params[:lang]}.html"
	end

end