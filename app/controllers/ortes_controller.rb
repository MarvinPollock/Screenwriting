class OrtesController < ApplicationController
  # GET /ortes
  # GET /ortes.json
  def index
    @ortes = Orte.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ortes }
    end
  end

  # GET /ortes/1
  # GET /ortes/1.json
  def show
    @orte = Orte.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @orte }
    end
  end

  # GET /ortes/new
  # GET /ortes/new.json
  def new
    @orte = Orte.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @orte }
    end
  end

  # GET /ortes/1/edit
  def edit
    @orte = Orte.find(params[:id])
  end

  # POST /ortes
  # POST /ortes.json
  def create
    @orte = Orte.new(params[:orte])

    respond_to do |format|
      if @orte.save
        format.html { redirect_to @orte, notice: 'Orte was successfully created.' }
        format.json { render json: @orte, status: :created, location: @orte }
      else
        format.html { render action: "new" }
        format.json { render json: @orte.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ortes/1
  # PUT /ortes/1.json
  def update
    @orte = Orte.find(params[:id])

    respond_to do |format|
      if @orte.update_attributes(params[:orte])
        format.html { redirect_to @orte, notice: 'Orte was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @orte.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ortes/1
  # DELETE /ortes/1.json
  def destroy
    @orte = Orte.find(params[:id])
    @orte.destroy

    respond_to do |format|
      format.html { redirect_to ortes_url }
      format.json { head :no_content }
    end
  end
end
