class Location < ActiveRecord::Base


	def set_latlon(lat, lng)
	  factory = RGeo::Geographic.spherical_factory(srid: 4326)
	  # NOTE: this method takes the LNG parameter first!
	  self.latlon = factory.point(lng, lat)

	end

	def self.import(file)
		spreadsheet = open_spreadsheet(file)
	  header = spreadsheet.row(1)
	  attributes = {}
	  spreadsheet.each_with_index do |row, index|
	  	next if index == 0
	  	location = Location.create(name: row[0])
	  	lat_lon = Coordinates.utm_to_lat_long("WGS-84", row[2].to_i, row[1].to_i, "48N")
	  	location.set_latlon(lat_lon[:lat], lat_lon[:long])
	  	location.save
	  end
	end

	def self.open_spreadsheet(file)
	  case File.extname(file.original_filename)
	  when ".csv" then Roo::Csv.new(file.path)
	  when ".xls" then Roo::Excel.new(file.path)
	  when ".xlsx" then Roo::Excelx.new(file.path)
	  else raise "Unknown file type: #{file.original_filename}"
	  end
	end

	def self.convert_latlon(points)
		arr = []
		factory = RGeo::Geographic.spherical_factory(srid: 4326)
		points.each do |point|
			arr << factory.point(point[1], point[0])
		end
		arr
	end

	def self.convert_to_point(lat, lng)
		factory = RGeo::Geographic.spherical_factory(srid: 4326)
		factory.point(lng, lat)
	end
end
