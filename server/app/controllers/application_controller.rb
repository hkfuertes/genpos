class ApplicationController < ActionController::Base
  @public = false
  before_action :authenticate_teacher!
  protected

  def authenticate_teacher!
    unless teacher_signed_in? && !@public
      redirect_to :new_teacher_session
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end

  def public!
    @public = true
  end
end
