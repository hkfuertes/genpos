class AssestmentsController < ApplicationController
  before_action :accept_all_params
  before_action :set_update_assestments, only: [:update]
  before_action :set_classroom, only: %i[edit update]
  before_action :set_assestments, only: [:edit]

  def index; end

  def show; end

  def edit
    @prep_assest = @assestments.map do |value|
      [
        value.student.id,
        JSON.parse(value.assestments).transform_keys(&:to_i).transform_values(&:to_i)
      ]
    end.to_h
  end

  def update
    @assestments.each do |key, assestment|
      values = create_value_set(key, assestment)
      current_assestment = Assestment.where(values.except(:assestments))
      if current_assestment.nil?
        current_assestment = Assestment.new(values)
        current_assestment.save
      else
        current_assestment.update(values)
      end
    end
    redirect_to :assestments
  end

  private

  def create_value_set(student_id, assestment)
    student = Student.find(student_id.delete_prefix('S').to_i)
    {
      classroom: @classroom, student:,
      assestments: assestment.to_json
    }
  end

  def set_update_assestments
    @assestments = params[:assestment].to_h.transform_values do |value|
      value.delete_if { |_, v| v.empty? }
    end.delete_if { |_, v| v.empty? }
  end

  def set_assestments
    @assestments = Assestment.where(classroom_id: params[:classroom])
  end

  def set_classroom
    @classroom = Classroom.find(params[:classroom])
  end

  def accept_all_params
    params.permit!
  end
end
