class EcardController < ApplicationController
  def new
	@ecard = Ecard.new
  end

  def create
    @ecard = Ecard.new(params[:ecard])
	@ecard.generate
    send_data @ecard.content, type: "plain/text", filename: "ecard-#{params[:ecard][:brand]}-#{params[:ecard][:lang]}.html"
  end

  def show
    @content
  end
end