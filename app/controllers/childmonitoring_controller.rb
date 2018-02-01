class ChildmonitoringController < ApplicationController

  PAGE_SIZE = 10

  def index
    @child = Child.find_by_id(params[:child_id])

    ## ANTHROPOMETRY
      @child_fol = @child.followups
      @child_anthrop = @child.anthropometry

    # MEDICAL HISTORY
      @child_test = @child.tests
      
    # ROUTINE-MEDICATIONS

    # PHYSICAL EXAMINATION
  end

  def search
      @page = (params[:page] || 0).to_i

      if params[:keywords].present? #if search parameters are entered...
        @keywords = params[:keywords]

        child_search_term = ChildSearchTerm.new(@keywords)
        @children = Child.where(
            child_search_term.where_clause,
            child_search_term.where_args).order(child_search_term.order).offset(PAGE_SIZE * @page).limit(PAGE_SIZE)
      else
        @children = Child.all.limit(0)
      end
  end

  private

  def find_child
  	if session[:child_id]
  		@child = Child.find_by_id(session[:child_id])
  	end
  end
end
