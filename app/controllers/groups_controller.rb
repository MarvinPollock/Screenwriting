class GroupsController < ApplicationController
  before_filter :ensure_signed_in
  load_and_authorize_resource
  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end




  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(params[:group])
    @group.num = params[:gNumber]
    @group.status = params[:gName]
    respond_to do |format|
      if g = Group.find(:first, :conditions => ["num = ?", params[:gNumber]])
        flash[:notice] = "Die Gruppe mit der Nummer #{@group.num}  existiert bereits."
        format.html { render action: "new"}
        format.json { render json: @group.errors }
      else
        if @group.save
          unless @group.users.exists?(current_user)
            @group.users << current_user
          end
          format.html { redirect_to @group, notice: 'Group was successfully created.' }
          format.json { render json: @group, status: :created, location: @group }
        else
          format.html { render action: "new" }
          format.json { render json: @group.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end
end
