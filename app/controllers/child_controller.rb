class ChildController < ApplicationController
	before_action :authenticate_user!

#===============================child/index-page====================================================
  #displays all children 
  def index
    @child = Child.all
  end

#==============================child/show===========================================================
  #shows the full details of a child
  def show
    @child =Child.find(params[:id])
    session[:child_id] = @child.id

    if !@child.done_assessment #if registration was not finished
      #done_assessment :see Child model
      flash[:notice] = "The anthropometric and Medical assessment details of #{@child.full_name} were not recorded..."
    end
  end

#=============================child/otp_book========================================================
  def otp_book
    @child_otp = Child.eligible_for_admission
  end

#=============================child/new=============================================================
  #add new child
  def new
    @child =Child.new   
  end

#=============================child/check===========================================================
#Search a child for a check-up or just monitor

  def check
    # ----------------------------------------------------------------------------
    # this is a search function
    # @found_person = nil

    if params[:search] #if the variable carries values...
      @found_results = Child.search(params[:search]) #search in DB

      #check the number of results found and assign to "found_person"
      if @found_results.length > 1
        @found_person = @found_results.first
      else
        @found_person = @found_results
      end
      # we need also to separate those that are admitted into programme
      # because the mthos searches for all
      #if assigned
      if @found_person
        session[:child_id] = @found_person.first.id
        redirect_to :controller => :check_up, :action => 'summary', :child_id => @found_person.first.id and return
      else
          flash[:error] = "No child is found..."
      end
    #-------if variable doesnt have value
    else
      render 'check'
    end

  end

#===================================================================================================
  def simple_show
    @child =Child.find(params[:id])
    session[:child_id] = @child.id
  end

#===================================================================================================
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
  
#==============================child/edit==============================================================
  def edit
    @child =Child.find(params[:id])
  end

#------------------------------------------------------------------------------------------------------
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

#==================================child/delete======================================================
  def delete
      @child =Child.find(params[:id])
  end

#----------------------------------------------------------------------------------------------------
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
