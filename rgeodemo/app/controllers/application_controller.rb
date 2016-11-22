class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def success_message
  	flash[:success] = I18n.t("common.success")
  end

  def fail_message
  	flash[:danger] = I18n.t("common.fail")
  end
end
