class StestsController < ApplicationController
  before_action :set_stest, only: %i[ show edit update destroy ]

  # GET /stests or /stests.json
  def index
    @stests = Stest.all
  end

  # GET /stests/1 or /stests/1.json
  def show
  end

  # GET /stests/new
  def new
    @stest = Stest.new
  end

  # GET /stests/1/edit
  def edit
  end

  # POST /stests or /stests.json
  def create
    @stest = Stest.new(stest_params)

    respond_to do |format|
      if @stest.save
        format.html { redirect_to stest_url(@stest), notice: "Stest was successfully created." }
        format.json { render :show, status: :created, location: @stest }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stests/1 or /stests/1.json
  def update
    respond_to do |format|
      if @stest.update(stest_params)
        format.html { redirect_to stest_url(@stest), notice: "Stest was successfully updated." }
        format.json { render :show, status: :ok, location: @stest }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stests/1 or /stests/1.json
  def destroy
    @stest.destroy

    respond_to do |format|
      format.html { redirect_to stests_url, notice: "Stest was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stest
      @stest = Stest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stest_params
      params.fetch(:stest, {})
    end
end
