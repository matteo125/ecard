class Ecard
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :content, :brand, :brand_downcase, :lang, :forward, :forward_sel, :width, :height, :pre_header_sel, :link_sel, :title, :pre_header, :src, :link, :alt
  BRANDS = { "prada": "PRADA", "miumiu": "MIU MIU" }

	def persisted?
  	false
	end

	def initialize options = {}
    @options = options
    @title = options[:title]
    @pre_header = options[:pre_header]
    @link = options[:link]
    @src = options[:src]
    @width = options[:width]
    @height = options[:height]
    @alt = options[:alt]
    @pre_header_sel = options[:pre_header_sel]
    @forward_sel = options[:forward_sel]

    @options[:brand] ||= "prada"
    @brand_downcase = @options[:brand].downcase ||= "prada"
    
    brand_param = options[:brand].downcase
    @content = File.read("config/template/ecard_template_#{brand_param}.html")
    #@translate = YAML.load_file("config/locales/translate_#{brand_param}.yml")
    @brand = BRANDS[brand_param.to_sym]
	end
end