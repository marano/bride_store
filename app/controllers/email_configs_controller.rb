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
    save_sucess
    redirect_to adm_path
  end

  # PUT /email_configs/1
  # PUT /email_configs/1.xml
  def update
    @email_config = EmailConfig.find(params[:id])

    if @email_config.update_attributes(params[:email_config])
      save_sucess
      redirect_to adm_path
    else
      save_error
      render :action => "edit"
    end
  end
end
