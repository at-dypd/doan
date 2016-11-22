class Admin::PlantOrdersController < AdminController
	before_action :conditions, :new_object, only: [:index]

	def index
		@plant_orders = @q.result.order(:id).page(params[:page]).per(params[:limit])
	end

	def create
		@plant_orders = PlantOrder.create(permit_params(params))
		@plant_orders.errors.blank? ? success_message : fail_message
		redirect_to :back
	end

	def update
		@plant_orders = PlantOrder.find(params[:id])
		@plant_orders.update(permit_params(params))
		@plant_orders.errors.blank? ? success_message : fail_message
		respond_to do |format|
			format.js
		end
	end

	def destroy
		@plant_orders = PlantOrder.find(params[:id])
		@plant_orders.destroy
		@plant_orders.errors.blank? ? success_message : fail_message
		redirect_to :back
	end

	private

	def conditions
		@q = PlantOrder.ransack(params[:q])
	end

	def new_object
		@new_object = PlantOrder.new
	end

	def permit_params(params)
		params.require(:plant_order).permit(:name, :description)
	end
end
