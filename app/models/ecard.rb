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
    @brand = options[:brand] ||= "prada"
    brand_param = options[:brand].downcase
	end
  
  def content
    template = ERB::new File.read("config/templates/template.html.erb")
    pre_header_template = ERB::new(File.read("config/templates/_pre_header.html.erb"),0,"","_erbout2").result binding
    link_template = ERB::new(File.read("config/templates/_link.html.erb"),0,"","_erbout2").result binding
    social_template = ERB::new(File.read("config/templates/_social.html.erb"),0,"","_erbout2").result binding
    forward_template = ERB::new(File.read("config/templates/_forward.html.erb"),0,"","_erbout2").result binding
    footer_template = ERB::new(File.read("config/templates/_footer.html.erb"),0,"","_erbout2").result binding
    template.result binding
  end

  def write_on_file
    path = "public/ecard.html"
    File.open(path, "w") do |f|
      f.write content
    end
  end
end