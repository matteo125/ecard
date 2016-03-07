class Ecard
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :content, :brand, :lang, :forward, :forward_sel, :width, :height, :pre_header_sel, :link_sel, :title, :pre_header, :src, :link, :alt
  BRANDS = { "prada": "PRADA", "miumiu": "MIU MIU" }

	def persisted?
  	false
	end

	def initialize options = {}
    options[:brand] ||= "prada"
  	@options = options
    brand_param = options[:brand].downcase
    @content = File.read("config/template/ecard_template_#{brand_param}.html")
    @translate = YAML.load_file("config/locales/translate_#{brand_param}.yml")
    @brand = BRANDS[brand_param.to_sym]
	end

  def generate
    sub_title
    select_header   
    sub_pre_header
    images_dimension
    set_src
    select_link
    set_images_attributes    
    select_forward
    sub_translations
  end

  private

  def sub_title
     @content.gsub!("titolo", @options[:title])
  end

  def select_header
    if @options[:pre_header_sel] == 'No'
      @content.gsub!("#p_h_yes_1", "<!--")
      @content.gsub!("#p_h_yes_2", "-->")
    else
      @content.gsub!("#p_h_yes_1", "")
      @content.gsub!("#p_h_yes_2", "")
    end
  end

  def sub_pre_header
    @content.gsub!("pre_header", @options[:pre_header])
  end

  def images_dimension
    @content.gsub!("img_width", @options[:width])
    @content.gsub!("img_height", @options[:height])
  end

  def set_src
    @content.gsub!("#src", @options[:src])
  end

  def select_link
    if @options[:link_sel] == 'No'
      @content.gsub!("#l_no_1", "<!--")
      @content.gsub!("#l_no_2", "-->")
    else
      @content.gsub!("#l_no_1", "")
      @content.gsub!("#l_no_2", "")
    end
  end

  def set_images_attributes
    @content.gsub!("link", @options[:link])
    @content.gsub!("#alt", @options[:alt])
  end

  def sub_translations
    @content.gsub!("If you have trouble seeing this e-mail please ", @translate[@options[:lang]]["browser_view_1"])
    @content.gsub!("click here</a> to unsubscribe.<br />", @translate[@options[:lang]]["footer_3"])
    @content.gsub!("click here", @translate[@options[:lang]]["browser_view_2"])
    @content.gsub!("To ensure that our communications are safely received in your inbox,<br/>please add ", @translate[@options[:lang]]["footer_1"])
    @content.gsub!("to your address book.", @translate[@options[:lang]]["footer_1_2"])
    @content.gsub!("Forward to a friend", @translate[@options[:lang]]["forward"])
    @content.gsub!("We legitimately collected your e-mail address in circumstances such as in stores or through the web site,<br />when you knowingly provided this information. We make our best effort in order to handle such information<br />in conformity with privacy regulations and in complete safety. Please ", @translate[@options[:lang]]["footer_2"])
    @content.gsub!("Click here</a> for information related to #{brand} company and legal information.", @translate[@options[:lang]]["legal_informations"])
  end

  def select_forward
    if @options[:forward_sel] == 'No'
      @content.gsub!("#f_no_1", "<!--")
      @content.gsub!("#f_no_2", "-->")
    else
      @content.gsub!("#f_no_1", "")
      @content.gsub!("#f_no_2", "") 
    end
  end
end