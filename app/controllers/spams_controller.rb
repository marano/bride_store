class SpamsController < ApplicationController

  before_filter :login_required

  layout 'site'

  def enviar
    @spam = Spam.find(params[:id])
    @spam.enviar    
    flash[:notice] = 'Divulgação enviada com sucesso!'
    redirect_to spams_path
  end

  def index
  end

  def show
    @spam = Spam.find(params[:id])
  end

  def new
    @spam = Spam.new
    old = Spam.last
    unless old.nil?
      @spam.to = old.to
    end
  end

  def edit
    @spam = Spam.find(params[:id])
  end

  def create
    @spam = Spam.new(params[:spam])
    @spam.list = current_list
    if @spam.save
      flash[:notice] = 'Spam was successfully created.'
      redirect_to(@spam)
    else
      render :action => "new"
    end
  end

  def update
    @spam = Spam.find(params[:id])
    
    params[:spam].delete :photo if params[:spam][:photo].nil?
    
    if @spam.update_attributes(params[:spam])
      flash[:notice] = 'Spam was successfully updated.'
      redirect_to(@spam)
    else
      render :action => "edit"
    end
  end

  def destroy
    @spam = Spam.find(params[:id])
    @spam.destroy

    redirect_to(spams_url)
  end
end

