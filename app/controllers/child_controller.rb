class ChildController < ApplicationController
	before_action :authenticate_user!
  
  def index
    @child = Child.all
  end

  def show
    @child =Child.find(params[:id])
    session[:child_id] = @child.id

    if !@child.done_assessment #if registration was not finished
      flash[:notice] = "The anthropometric and Medical assessment details of #{@child.full_name} were not recorded..."
    end
  end

  def new
    @child =Child.new   
  end

  def check
    @found_person = nil
    if params[:search]
      @found_results = Child.search(params[:search])

      if @found_results.length > 1
        @found_person = @found_results.first
      else
        @found_person = @found_results
      end

      if @found_person
        session[:child_id] = @found_person.first.id
        redirect_to :controller => :check_up, :action => 'new', :child_id => @found_person.first.id and return
      else
          flash[:error] = "No child is found..."
      end
    else
      render 'check'
    end

  end

  def simple_show
    @child =Child.find(params[:id])
  end



 def create
    @child = Child.new(child_params)

    if @child.new_record?
      if @child.save
        redirect_to(:controller => 'child', :action => "simple_show", :id => @child.id)

      else
        render ('new')
      end
    else
      flash[:notice] = "The name already exists in database"
      render "new"
    end
  end
  


  def edit
    @child =Child.find(params[:id])
  end



  def update
    @child = Child.find(params[:id])

    if @child.update_attributes(child_params)
      flash[:notice] = "Child details updated successfully"

      if @child.anthropometry && @child.tests && @child.admission
        redirect_to(:action => 'show', :id => @child.id)
      else
        redirect_to(:action => 'simple_show', :id => @child.id)
      end
    else
      render('edit')
    end
  end


  def delete
      @child =Child.find(params[:id])
  end

  def destroy
      child =Child.find(params[:id]).destroy
      flash[:notice]= "#{child.full_name} details destroyed successfully"
      redirect_to(:action => 'index')
  end

private
  def child_params
    params.require(:child).permit(:reg_number, :first_name, :last_name, :guardian_name, :twin_child,
    	:dob, :sex, :trad_authority, :village, :district, :HIV_serostatus, :maternal_HIV_serostatus, :on_ART)
  end

end
