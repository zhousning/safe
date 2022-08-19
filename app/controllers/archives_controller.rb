class ArchivesController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #load_and_authorize_resource

   
  def index
    @factory = my_factory
    @archives = @factory.archives
    @archive = Archive.new
  end
   

   
  def show
    @factory = my_factory
    @archive = @factory.archives.find(params[:id])
  end
   

   
  def new
    @factory = my_factory
    @archive = Archive.new
    
  end
   

   
  def create
    @factory = my_factory
    @archive = Archive.new(archive_params)
    @archive.factory = @factory
    if @archive.save
      redirect_to factory_archives_url(idencode(@factory.id))
    else
      render :new
    end
  end
   

   
  def edit
    @factory = my_factory
    @archive = @factory.archives.find(params[:id])
  end
   

   
  def update
    @factory = my_factory
    @archive = @factory.archives.find(params[:id])
    if @archive.update(archive_params)
      #redirect_to archive_path(@archive) 
      redirect_to factory_archives_url(idencode(@factory.id))
    else
      render :edit
    end
  end
   

   
  def destroy
    @factory = my_factory
    @archive = @factory.archives.find(params[:id])
    @archive.destroy
    redirect_to :action => :index
  end
   

  private
    def archive_params
      params.require(:archive).permit( :name, :desc)
    end
  
  
  
end

