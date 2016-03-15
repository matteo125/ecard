class EcardController < ApplicationController
  def new
	@ecard = Ecard.new
  end

  def create
    @ecard = Ecard.new(params[:ecard])
    I18n.locale = params[:ecard][:lang] || I18n.default_locale
    @ecard.write_on_file
  end

  def download
  	send_file("#{Rails.root}/public/ecard.html")
  end
end