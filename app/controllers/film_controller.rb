class FilmController < ApplicationController

@selected_nav = "Films"

  def search
    @searchTerm = params[:search]
    if @searchTerm != nil
      @films = Film.search(@searchTerm)
    else
      @films = Film.sorted
    end
  end

  def view
    @film = Film.find(params[:id])
  end

  def add
    @film = Film.new({:title => "Movie Title", :year => Time.now.year})
  end

  def remove
    @film = Film.find(params[:id])
  end

  def edit
    @film = Film.find(params[:id])
  end

  #C(R)UD
  def create
    # Instantiate a new object using form parameters
    @film = Film.new(film_params)
    # Save the object
    if @film.save
        # If save succeeds, redirect to the index action
        flash[:notice] = "Film created successfully."
        redirect_to(:action => 'view', :id => @film.id)
    else
        # If save fails, redisplay the form so user can fix problems
        render('add')
    end
  end

  def update
    # Find an existing object using form parameters
    @film = Film.find(params[:id])
    # Update the object
    if @film.update_attributes(film_params)
      # If update succeeds, redirect to the index action
      flash[:notice] = "Film updated successfully."
      redirect_to(:action => 'view', :id => @film.id)
    else
      # If update fails, redisplay the form so user can fix problems
      render('edit')
    end
  end

  def destroy
    film = Film.find(params[:id]).destroy
    flash[:notice] = "#{film.title} (#{film.year}) destroyed successfully."
    redirect_to(:action => 'search')
  end

  private
  def film_params
    # same as using "params[:subject]", except that it:
    # - raises an error if :subject is not present
    # - allows listed attributes to be mass-assigned
    params.require(:film).permit(:title, :year, :synopsis)
  end


end
