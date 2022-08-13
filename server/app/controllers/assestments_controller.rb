class AssestmentsController < ApplicationController

  def index; end

  # GET /assestments/1 or /assestments/1.json
  def show; end

  # GET /assestments/1/edit
  def edit
    @assestments = Assestment.where(classroom_id: params[:classroom])
    @classroom = Classroom.find(params[:classroom])
  end

  # POST /assestments or /assestments.json
  def create
    @assestment = Assestment.new(assestment_params)

    respond_to do |format|
      if @assestment.save
        format.html { redirect_to assestment_url(@assestment), notice: 'Assestment was successfully created.' }
        format.json { render :show, status: :created, location: @assestment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @assestment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assestments/1 or /assestments/1.json
  def update
    respond_to do |format|
      if @assestment.update(assestment_params)
        format.html { redirect_to assestment_url(@assestment), notice: 'Assestment was successfully updated.' }
        format.json { render :show, status: :ok, location: @assestment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @assestment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assestments/1 or /assestments/1.json
  def destroy
    @assestment.destroy

    respond_to do |format|
      format.html { redirect_to assestments_url, notice: 'Assestment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_assestment
    @assestment = Assestment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def assestment_params
    params.fetch(:assestment, {})
  end
end
