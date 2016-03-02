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
		#data = File.load Rails.root.join 'config/template/ecard_template.html'
		@content = ""
		file = File.open Rails.root.join ('config/template/ecard_template.html')
		@content = file.read
	end



end