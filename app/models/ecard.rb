class Ecard

	extend ActiveModel::Naming
  	include ActiveModel::Conversion

  	def persisted?
    	false
  	end

	attr_accessor :lang, :title, :pre_header, :pre_header_sel, :width, :height, :src, :link, :link_sel, :alt, :forward_sel

	def initialize lang = "", title = "", pre_header = "", pre_header_sel = "", width = "", height = "", src = "", link = "", link_sel = "", alt = "", forward_sel = ""
    	@lang = lang
    	@title = title
    	@pre_header = pre_header
      @pre_header_sel = pre_header_sel
    	@width = width
    	@height = height
    	@src = src
    	@link = link
      @link_sel = link_sel
    	@alt = alt
    	@forward_sel = forward_sel
	end

	def load_template

		#@content = file.read
	end



end