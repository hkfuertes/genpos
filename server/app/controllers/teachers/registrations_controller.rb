# frozen_string_literal: true

class Teachers::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :configure_sign_up_params, only: [:create]
  prepend_before_action :configure_account_update_params, only: [:update]
  prepend_before_action :redirect_if_teacher_is_not_admin, only: [:new]
  prepend_before_action :require_no_authentication, only: :cancel

  # POST /resource
  def new
    @teachers = Teacher.all
    super
  end

  # POST /resource
  def create
    @teachers = Teacher.all
    super
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # TODO: return proper 404
  def redirect_if_teacher_is_not_admin
    head :not_found unless current_teacher.admin?
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[attribute name last_name])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    # devise_parameter_sanitizer.permit(:account_update, keys: [:name, :last_name, :classrooms, :attribute])
    devise_parameter_sanitizer.permit(:account_update) do |teacher|
      teacher.permit(:name, :last_name, :password, :password_confirmation, :current_password, { classrooms: [] })
    end
  end

  def account_update_params
    params = devise_parameter_sanitizer.sanitize(:account_update)
    if params.key?(:classrooms)
      classrooms_obj = Classroom.where(id: params[:classrooms])
      params[:classrooms] = classrooms_obj
    else
      params[:classrooms] = []
    end
    params
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def sign_up(resource_name, resource)
    # sign_in(resource_name, resource)
  end

  # The path used after sign up. You need to overwrite this method
  # in your own RegistrationsController.
  def after_sign_up_path_for(*)
    :new_teacher_registration
  end
end
