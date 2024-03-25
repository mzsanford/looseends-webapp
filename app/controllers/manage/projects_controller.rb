class Manage::ProjectsController < Manage::ManageController
  def index
    @projects = Project.all
    if (params[:status].present?)
      @projects = @projects.has_status(params[:status])
    end
    if (params[:assigned].present?)
      @projects = @projects.has_assigned(params[:assigned])
    end
    @projects = @projects.paginate(page: params[:page])
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to [:manage, @project]
    else
      render "new"
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to [:manage, @project]
    else
      render 'edit'
    end
  end

  protected

  def project_params
    params.require(:project).permit(
      :name,
      :description,
      :more_details,
      :status,
      :street,
      :street_2,
      :city,
      :state,
      :country,
      :postal_code,
      :craft_type,
      :has_pattern,
      :material_type,
      :crafter_name,
      :crafter_description,
      :crafter_dominant_hand,
      :recipient_name,
      :can_publicize,
      :terms_of_use,
      :no_smoke,
      :no_cats,
      :no_dogs,
      :has_smoke_in_home,
      in_home_pets: [],
      append_crafter_images: [],
      append_project_images: [],
      append_pattern_files: [],
      append_material_images: []
    )
  end
end
