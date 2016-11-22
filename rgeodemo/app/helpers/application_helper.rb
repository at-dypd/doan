module ApplicationHelper

	def item_position(params, index)
		params[:page].to_i * params[:limit].to_i + index + 1
	end
end
