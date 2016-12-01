class ExportController < ApplicationController
	before_action :init_data, only: [:export_statitic_medicinal_plant]

	def export_statitic_medicinal_plant
		@medicinal_plants = @q.result.order(:name)
		respond_to do |format|
      format.pdf do
        render pdf: "statitic_pdf_data"   # Excluding ".pdf" extension.
      end
    end
	end

	private

	def init_data
		@q = MedicinalPlant.ransack(params[:q])
	end
end
