class FileLibsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

   
  def index
    @factory = my_factory
    @portfolio = Portfolio.find(params[:portfolio_id])
    @archive = @portfolio.archive
    @file_libs = @portfolio.file_libs
    gon.portfolio = @portfolio.id
  end
   
  def destroy
    @portfolio = Portfolio.find(params[:portfolio_id])
    @file_lib = @portfolio.file_libs.find(params[:id])
    @file_lib.destroy
    redirect_to :action => :index
  end
   

  def download
    @file_lib = FileLib.find(params[:id])

    if @file_lib 
      send_file File.join(Rails.root, "public", @file_lib.path), :type => "application/force-download", :x_sendfile=>true
    end
  end
  
  

  

  private
    def file_lib_params
      params.require(:file_lib).permit( :name, :path, :file_type)
    end
  
  
  
end

