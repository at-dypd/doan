class Admin::UsedPartsController < AdminController
	before_action :conditions, :new_object, only: [:index]

	def index
		@used_parts = @q.result.order(:id).page(params[:page]).per(params[:limit])
	end

	def create
		@used_part = UsedPart.create(permit_params(params))
		@used_part.errors.blank? ? success_message : fail_message
		redirect_to :back
	end

	def update
		@used_part = UsedPart.find(params[:id])
		@used_part.update(permit_params(params))
		@used_part.errors.blank? ? success_message : fail_message
		respond_to do |format|
			format.js
		end
	end

	def destroy
		@used_part = UsedPart.find(params[:id])
		@used_part.destroy
		@used_part.errors.blank? ? success_message : fail_message
		redirect_to :back
	end

	private

	def conditions
		@q = UsedPart.ransack(params[:q])
	end

	def new_object
		@new_object = UsedPart.new
	end

	def permit_params(params)
		params.require(:used_part).permit(:name, :description)
	end
end
