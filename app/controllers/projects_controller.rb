class ProjectsController < ApplicationController
  before_filter :ensure_signed_in
  load_and_authorize_resource
  respond_to :json, :html
  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    @pads = Pad.find_all_by_p_name(@project.name)
    @frames = Frame.find_all_by_p_name(@project.name)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  def loadFrames
    if projects = Project.all
      gefunden = false
      projects.each { |proj|
          if proj.pads.empty?
            next
          else
            if @pad = proj.pads.find(:first, :conditions => ["id=?", params[:pad][:id]])
              gefunden = true
              break
            else
              next
            end
          end
      }
    end

    #@frames = Frame.find_all_by_p_name(@project.name)

    if gefunden
      @frames = @pad.frames
      respond_with(@frames, :location => nil)
    else
      respond_with(:error => @frames, :location => nil)
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @group = Group.find(:first, :conditions => ["num=?", params[:gNumber]])
    @project = Project.new
    @project.name = params[:pName]
    respond_to do |format|
      if @group
        group.projects << @project
        render :text => 'Project was successfully created.'
      else
        render :text => 'Error, please try later.'
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end
end
