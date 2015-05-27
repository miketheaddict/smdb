class FilmmakerController < ApplicationController
  def search
    @searchTerm = params[:search]
    if @searchTerm != nil
      @filmmakers = Filmmaker.search(@searchTerm)
    else
      @filmmakers = Filmmaker.sorted
    end
  end

  def view
    @filmmaker = Filmmaker.find(params[:id])
  end

  def add
    @filmmaker = Filmmaker.new({:firstName => "The Next", :lastName => "Spielberg", :year => 1})
  end

  def remove
    @filmmaker = Filmmaker.find(params[:id])
  end

  def edit
    @filmmaker = Filmmaker.find(params[:id])
  end

  #C(R)UD
  def create
    # Instantiate a new object using form parameters
    @filmmaker = Filmmaker.new(filmmaker_params)
    # Save the object
    if @filmmaker.save
        # If save succeeds, redirect to the index action
        flash[:notice] = "Filmmaker added successfully."
        redirect_to(:action => 'view', :id => @filmmaker.id)
    else
        # If save fails, redisplay the form so user can fix problems
        render('add')
    end
  end

  def update
    # Find an existing object using form parameters
    @filmmaker = Filmmaker.find(params[:id])
    # Update the object
    if @filmmaker.update_attributes(filmmaker_params)
      # If update succeeds, redirect to the index action
      flash[:notice] = "filmmaker updated successfully."
      redirect_to(:action => 'view', :id => @filmmaker.id)
    else
      # If update fails, redisplay the form so user can fix problems
      render('edit')
    end
  end

  def destroy
    filmmaker = Filmmaker.find(params[:id]).destroy
    flash[:notice] = "#{filmmaker.firstName} #{filmmaker.lastName} destroyed successfully."
    redirect_to(:action => 'search')
  end

  private
  def filmmaker_params
    # same as using "params[:subject]", except that it:
    # - raises an error if :subject is not present
    # - allows listed attributes to be mass-assigned
    params.require(:filmmaker).permit(:firstName, :lastName, :birthDate, :bio, :school, :year)
  end
end
