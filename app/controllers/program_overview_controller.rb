class ProgramOverviewController < ApplicationController
  def index
  end

  def location
  end

  def discharge
    
    #========================================================================================
      @discharge = Discharge.joins(:child).all
      @child_cured = Discharge.joins(:child).while_cured
      @child_dead = Discharge.joins(:child).while_dead
      @child_defaulted = Discharge.joins(:child).while_defaulted
      @child_nonresponse = Discharge.joins(:child).while_nonresponse
      @child_transferred= Discharge.joins(:child).while_transferred

  end

  def treatment_referral
  end

  def stock_management
  end

  def admissions
    #========================================================================================
    #Children from 6 months to 0 day old
      @male_6_months_old = Child.joins(:admission).male_6_months_old
      @female_6_months_old = Child.joins(:admission).female_6_months_old

    #========================================================================================
    #Children from 59 months to 6 months old
      @male_59_months_old = Child.joins(:admission).male_59_months_old
      @female_59_months_old = Child.joins(:admission).female_59_months_old

    #========================================================================================
    #Children from 60 months to 12 years old
      @male_12_years_old = Child.joins(:admission).male_12_years_old
      @female_12_years_old = Child.joins(:admission).female_12_years_old

    #========================================================================================
      @child = Child.joins(:admission).all

      @child_male = Child.joins(:admission).is_male
      @child_female = Child.joins(:admission).is_female
  end


  def transfer 	  	
  end	  
end
