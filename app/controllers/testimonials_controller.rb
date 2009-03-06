class TestimonialsController < ApplicationController

  layout 'adm'  
  
  # GET /testimonials
  # GET /testimonials.xml
  def index
    @testimonials = Testimonial.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @testimonials }
    end
  end

  # GET /testimonials/1
  # GET /testimonials/1.xml
  def show
    @testimonial = Testimonial.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @testimonial }
    end
  end

  # GET /testimonials/new
  # GET /testimonials/new.xml
  def new
    @testimonial = Testimonial.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @testimonial }
    end
  end

  # GET /testimonials/1/edit
  def edit
    @testimonial = Testimonial.find(params[:id])
  end

  # POST /testimonials
  # POST /testimonials.xml
  def create
    @testimonial = Testimonial.new(params[:testimonial])

    respond_to do |format|
      if @testimonial.save
        flash[:notice] = 'Testimonial was successfully created.'
        format.html { redirect_to(@testimonial) }
        format.xml  { render :xml => @testimonial, :status => :created, :location => @testimonial }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @testimonial.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /testimonials/1
  # PUT /testimonials/1.xml
  def update
    @testimonial = Testimonial.find(params[:id])

    respond_to do |format|
      if @testimonial.update_attributes(params[:testimonial])
        flash[:notice] = 'Testimonial was successfully updated.'
        format.html { redirect_to(@testimonial) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @testimonial.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /testimonials/1
  # DELETE /testimonials/1.xml
  def destroy
    @testimonial = Testimonial.find(params[:id])
    @testimonial.destroy

    respond_to do |format|
      format.html { redirect_to(testimonials_url) }
      format.xml  { head :ok }
    end
  end
end
