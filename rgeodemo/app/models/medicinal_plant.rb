class MedicinalPlant < ActiveRecord::Base
	mount_uploader :plant_avatar, PlantAvatarUploader
	mount_uploaders :plant_images, PlantImageUploader
	DEFAULT_ATTRIBUTES = [:name, :scientific_name, :plant_class_id, :plant_phylum_id, :plant_order_id,
												:plant_kingdom_id, :life_type_id, :plant_avatar]
	has_many :medicinal_plants_locations, foreign_key: :medicinal_plant_id
	has_many :medicinal_plants_plant_habitats, foreign_key: :medicinal_plant_id
	has_many :medicinal_plants_used_parts, foreign_key: :medicinal_plant_id
	has_many :used_parts, through: :medicinal_plants_used_parts
	has_many :plant_habitats, through: :medicinal_plants_plant_habitats
	has_many :locations, through: :medicinal_plants_locations
	belongs_to :life_type
	belongs_to :plant_phylum
	belongs_to :plant_class
	belongs_to :plant_order
	belongs_to :plant_kingdom
	# description
	# class: lop, phylum: nganh, order: bo, kingdom: gioi, life_type: dang song, family: ho, plant_habitat: sinh canh
	def self.import(file)
	  spreadsheet = open_spreadsheet(file)
	  header = spreadsheet.row(1)
	  attributes = {}
	  spreadsheet.each_with_index do |row, index|
	  	next if index == 0
	  	next if row[1].blank?
	  	attributes[:name] 									= row[1]
	  	attributes[:scientific_name] 				= row[2]
	  	attributes[:plant_order_id] 				= self.get_plant_order(row[3]).try(:id)
	  	attributes[:plant_class_id] 				= self.get_plant_class(row[4]).try(:id)
	  	attributes[:plant_phylum_id] 				= self.get_plant_phylum(row[6]).try(:id)
	  	attributes[:life_type_id] 					= self.get_life_type(row[7]).try(:id)
	  	plant_habitats 											= self.get_plant_habitats(row[8])
	  	used_parts 													= self.get_used_parts(row[9])
	  	attributes[:description] 						= row[10]
	  	medicinal_plant = create(attributes)
	  	medicinal_plant.plant_habitats << plant_habitats if plant_habitats
	  	medicinal_plant.used_parts << used_parts if used_parts
	  end
	end

	def self.import_location(file)
		spreadsheet = open_spreadsheet(file)
	  header = spreadsheet.row(1)
	  attributes = {}
	  spreadsheet.each_with_index do |row, index|
	  	next if index == 0
	  	next if row[1].blank?
	  	medicinal_plant = MedicinalPlant.find_by(name: row[1]) || MedicinalPlant.create(name: row[1])
	  	(row.length-2).times do |cell_index|
	  		pos = cell_index + 1
	  		next if row[pos].blank?
	  		location = Location.find_by(name: "Ô #{cell_index}")
	  		next if location.blank?
	  		medicinal_plant.medicinal_plants_locations.create(location_id: location.id, quantity: row[pos])
	  	end
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

	def self.get_plant_class(name)
		plant_class = PlantClass.find_by(name: name)
		plant_class = PlantClass.create(name: name) if plant_class.blank?
		plant_class
	end

	def self.get_plant_phylum(name)
		plant_phylum = PlantPhylum.find_by(name: name)
		plant_phylum = PlantPhylum.create(name: name) if plant_phylum.blank?
		plant_phylum
	end

	def self.get_plant_order(name)
		plant_order = PlantOrder.find_by(name: name)
		plant_order = PlantOrder.create(name: name) if plant_order.blank?
		plant_order
	end

	# def self.get_plant_family(name)
	# 	plant_phylum = PlantPhylum.find_by(name: name)
	# 	plant_phylum = PlantPhylum.create(name: name) if plant_phylum.blank?
	# 	plant_phylum
	# end

	def self.get_life_type(name)
		life_type = LifeType.find_by(name: name)
		life_type = LifeType.create(name: name) if life_type.blank?
		life_type
	end

	def self.get_plant_habitats(names)
		return if names.blank?
		plant_habitats = []
		names = names.split(",").collect{|c| c.strip}
		plant_habitats_queried = PlantHabitat.where(name: names)
		names_queried = plant_habitats_queried.pluck(:name)
		names.each do |n|
			next if names_queried.include?(n)
			plant_habitats << PlantHabitat.create(name: n)
		end
		(plant_habitats_queried + plant_habitats).try(:uniq)
	end

	def self.get_used_parts(names)
		return if names.blank?
		used_parts = []
		names = names.split(",").collect{|c| c.strip}
		used_parts_queried = UsedPart.where(name: names)
		names_queried = used_parts_queried.pluck(:name)
		names.each do |n|
			next if names_queried.include?(n)
			used_parts << UsedPart.create(name: n)
		end
		(used_parts_queried + used_parts).try(:uniq)
	end
end
