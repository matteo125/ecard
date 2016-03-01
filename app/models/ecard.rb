class Ecard

	extend ActiveModel::Naming
  	include ActiveModel::Conversion

  	def persisted?
    	false
  	end

	attr_accessor :lang, :title, :pre_header, :width, :height, :src, :link, :alt, :forward

	def initialize lang = "", title = "", pre_header = "", width = ""
    	@lang = lang
    	@title = title
    	@pre_header = pre_header
    	@width = width
	end

	def load_template
		data = YAML.load_file Rails.root.join 'config/template/ecard_template.html'
	end



end