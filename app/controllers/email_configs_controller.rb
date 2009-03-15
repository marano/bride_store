class EmailConfigsController < ApplicationController

  layout 'adm'
  
  before_filter :adm_required

  # GET /email_configs/1/edit
  def edit
    @email_config = email_config
  end

  def create
    @email_config = EmailConfig.new(params[:email_config])
    @email_config.save
    redirect_to adm_path
  end

  # PUT /email_configs/1
  # PUT /email_configs/1.xml
  def update
    @email_config = EmailConfig.find(params[:id])

    if @email_config.update_attributes(params[:email_config])
      flash[:notice] = 'EmailConfig was successfully updated.'
      redirect_to adm_path
    else
      render :action => "edit"
    end
  end
end
