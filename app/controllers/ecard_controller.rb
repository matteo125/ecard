class EcardController < ApplicationController
  def new
	@ecard = Ecard.new
  end

  def create
    @ecard = Ecard.new(params[:ecard])
    I18n.locale = params[:ecard][:lang] || I18n.default_locale
    send_data @ecard.content, type: "plain/text", filename: "ecard-#{params[:ecard][:brand]}-#{params[:ecard][:lang]}.html"
  end
end