class Ecard
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  include ActiveModel::Model

  attr_accessor :content, :brand, :brand_downcase, :lang, :forward, :forward_sel, :width, :height, :pre_header_sel, :link_sel, :title, :pre_header, :src, :link, :alt

	def persisted?
  	false
	end
  
  def content
    template = ERB::new File.read("config/templates/template_#{@brand}.html.erb")
    pre_header_template = ERB::new(File.read("config/templates/_pre_header.html.erb")).result binding
    link_template = ERB::new(File.read("config/templates/_link.html.erb")).result binding
    forward_template = ERB::new(File.read("config/templates/_forward.html.erb")).result binding
    template.result binding
  end

  def write_on_file
    path = "public/ecard.html"
    File.open(path, "w") do |f|
      f.write content
    end
  end
end