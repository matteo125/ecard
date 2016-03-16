class Ecard
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :content, :brand, :brand_downcase, :lang, :forward, :forward_sel, :width, :height, :pre_header_sel, :link_sel, :title, :pre_header, :src, :link, :alt

	def persisted?
  	false
	end

	def initialize options = {}
    @title = options[:title]
    @pre_header = options[:pre_header]
    @link = options[:link]
    @src = options[:src]
    @width = options[:width]
    @height = options[:height]
    @alt = options[:alt]
    @pre_header_sel = options[:pre_header_sel]
    @forward_sel = options[:forward_sel]
    @brand = options[:brand]
	end
  
  def content
    template = ERB::new File.read("config/templates/template.html.erb")
    pre_header_template = ERB::new(File.read("config/templates/_pre_header.html.erb")).result binding
    link_template = ERB::new(File.read("config/templates/_link.html.erb")).result binding
    social_template = ERB::new(File.read("config/templates/_social.html.erb")).result binding
    forward_template = ERB::new(File.read("config/templates/_forward.html.erb")).result binding
    footer_template = ERB::new(File.read("config/templates/_footer.html.erb")).result binding
    template.result binding
  end

  def write_on_file
    path = "public/ecard.html"
    File.open(path, "w") do |f|
      f.write content
    end
  end
end