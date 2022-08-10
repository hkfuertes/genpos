# frozen_string_literal: true

class Teachers::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :configure_sign_up_params, only: [:create]
  prepend_before_action :configure_account_update_params, only: [:update]
  prepend_before_action :redirect_if_teacher_is_not_admin, only: [:new]
  prepend_before_action :require_no_authentication, only: :cancel
  before_action :set_teacher_by_id, only: %i[admin destroy]
  before_action :set_admin_action, only: [:admin]

  # POST /resource
  def new
    @teachers = Teacher.all
    super
  end

  # DELETE /resource
  def destroy
    @teacher_by_id.destroy
    redirect_to :new_teacher_registration
  end

  def admin
    @teacher_by_id[:admin] = @promote
    @teacher_by_id.save
    redirect_to :new_teacher_registration
  end

  protected

  def set_teacher_by_id
    @teacher_by_id = Teacher.find(params[:id])
  end

  def set_admin_action
    @promote = params[:act] == 'promote'
  end

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
  def after_sign_up_path_for(_resource)
    :new_teacher_registration
  end

  def sign_up(resource_name, resource)
    # sign_in(resource_name, resource)
  end
end
