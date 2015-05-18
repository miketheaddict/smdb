class RolesController < ApplicationController
  def add
    @role = Role.new({:credit => "Uncredited", :cast => "false"})
  end

  def remove
    @role = Role.find(params[:id])
  end

  def edit
    @role = Role.find(params[:id])
  end

  #C(R)UD
  def create
    # Instantiate a new object using form parameters
    @role = Role.new(role_params)
    if @role.save
          # If save succeeds, redirect to the index action
          flash[:notice] = "Role created successfully."
          redirect_to(:action => 'view', :id => @role.id)
          return
      else
          # If save fails, redisplay the form so user can fix problems
          render('add')
      end
  end

  def update
    # Find an existing object using form parameters
    @role = Role.find(params[:id])
    # Update the object
	if @role.update_attributes(role_params)
	# If update succeeds, redirect to the index action
	flash[:notice] = "Role updated successfully."
	redirect_to(:action => 'view', :id => @role.id)
	return
	else
		# If update fails, redisplay the form so user can fix problems
		render('edit')
	end
  end

  def destroy
    role = Role.find(params[:id]).destroy
    flash[:notice] = "#{role.title} (#{role.year}) destroyed successfully."
    redirect_to(:action => 'search')
  end

  private
  def role_params
    # same as using "params[:subject]", except that it:
    # - raises an error if :subject is not present
    # - allows listed attributes to be mass-assigned
    params.require(:role).permit(:credit, :cast)
  end
end
