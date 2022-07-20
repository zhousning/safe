class GrpInspectorsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  authorize_resource 


  def index
    @inspectors = WxUser.all
  end

end
