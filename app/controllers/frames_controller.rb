class FramesController < ApplicationController
  before_filter :ensure_signed_in
  # GET /frames
  # GET /frames.json
  def index
    @frames = Frame.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @frames }
    end
  end

  # GET /frames/1
  # GET /frames/1.json
  def show
    @frame = Frame.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @frame }
    end
  end

  def generate_password(length=6)
    chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789'
    password = ''
    length.times { password << chars[rand(chars.size)] }
    password
  end

  # GET /frames/new
  # GET /frames/new.json
  def new
    @frame = Frame.new
    @random_text = generate_password(15)
    @pad = Pad.find(:first, :conditions => ["id=?", params[:pad_id]])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @frame }
    end
  end

  # GET /frames/1/edit
  def edit
    @frame = Frame.find(params[:id])
  end

  # POST /frames
  # POST /frames.json
  def create
    @pad = Pad.find(:first, :conditions => ["id=?", params[:frame][:pad_id]])
    @frame = Frame.new
    @frame.name = params[:frame][:name]
    @frame.pad_id = params[:frame][:pad_id]
    @frame.descr = params[:frame][:descr]
    @frame.image = params[:frame][:image]
    respond_to do |format|
      @pad.frames << @frame
      format.html { redirect_to @frame, notice: 'Frame was successfully created.' }
      format.json { render json: @frame, status: :created, location: @frame }
    end
  end

  # PUT /frames/1
  # PUT /frames/1.json
  def update
    @frame = Frame.find(params[:id])

    respond_to do |format|
      if @frame.update_attributes(params[:frame])
        format.html { redirect_to @frame, notice: 'Frame was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @frame.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /frames/1
  # DELETE /frames/1.json
  def destroy
    @frame = Frame.find(params[:id])
    @frame.destroy

    respond_to do |format|
      format.html { redirect_to frames_url }
      format.json { head :no_content }
    end
  end
end
