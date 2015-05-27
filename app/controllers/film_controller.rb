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
    @film.trivia.build
  end

  def remove
    @film = Film.find(params[:id])
  end

  def edit
    @film = Film.find(params[:id])
    #@testFilmmaker = Filmmaker.new({:firstName=>"foist", :lastName=>"last"})
    #@testRole = Role.new({:credit=>"DINGUS HANDLER"})
    #@testRole.filmmaker = @testFilmmaker
    #@film.roles << @testRole
    #@film.save
    #redirect_to(:action => 'view', :id => @film.id)
  end

  #C(R)UD
  def create
    # Instantiate a new object using form parameters
    @film = Film.new(film_params)
    # Save the object
    if params[:add_trivium]
      # add empty trivia associated with @film
      @film.trivia.build
    elsif params[:remove_trivium]
      # nested model that have _destroy attribute = 1 automatically deleted by rails
    else
      if @film.save
          # If save succeeds, redirect to the index action
          flash[:notice] = "Film created successfully."
          redirect_to(:action => 'view', :id => @film.id)
          return
      #else
          # If save fails, redisplay the form so user can fix problems
          #render('add')
      end
    end
    render('add')
  end

  def update
    # Find an existing object using form parameters
    @film = Film.find(params[:id])

    if params[:add_trivium]
      #rebuild the trivia attributes that don't have an id
      unless params[:film][:trivium_attributes].blank?
        for attribute in params[:film][:trivia_attributes]
          @film.trivia.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
        end
      end
      # add on more empty trivium attribute
      @film.trivia.build
    elsif params[:remove_trivium]
      # collect all marked for delete ingredient ids
      removed_trivia = params[:film][:trivia_attributes].collect { |i, att| att[:id] if (att[:id] && att[:_destroy].to_i == 1) }
      # physically delete the trivia from database
      Trivium.delete(removed_ingredients)
      flash[:notice] = "Trivia removed."
      for attribute in params[:film][:trivia_attributes]
        # rebuild ingredients attributes that doesn't have an id and its _destroy attribute is not 1
        @film.trivia.build(attribute.last.except(:_destroy)) if (!attribute.last.has_key?(:id) && attribute.last[:_destroy].to_i == 0)
      end
    else
    # Update the object
      if @film.update_attributes(film_params)
        # If update succeeds, redirect to the index action
        flash[:notice] = "Film updated successfully."
        redirect_to(:action => 'view', :id => @film.id)
        return
      #else
        # If update fails, redisplay the form so user can fix problems
      #  render('edit')
      end
    end
    render('edit')
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
    params.require(:film).permit(:title, :year, :synopsis, :url)
  end


#DELETE THIS
  def detour
    @testFilmmaker = Filmmaker.new({:firstName=>"foist", :lastName=>"last"})
    @testRole = Role.new({:credit=>"DINGUS HANDLER"})
    @film.role = @testRole
    @film.save
    redirect_to(:action => 'view', :id => @film.id)
  end

end
