class ProgramOverviewController < ApplicationController
  def index
  end

  def location
  end

  def discharge
  end

  def treatment_referral
  end

  def stock_management
  end

  def admissions

    @child = Child.joins(:admission).all

    @child_male = Child.is_male
    @child_female = Child.is_female

    @child_male_infants = for child in @child_male child.age_in_months < 60 end

    
    @child_male_adm = @child_male.each do |c| c.admission end
    @child_female_adm = @child_female.each do |c| c.admission end

    @male_admin = Admission.joins(:child).where(:child => {:sex => "male"})
  end

  def transfer 	  	
  end	 

end
