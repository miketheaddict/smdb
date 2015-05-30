class FilmController < ApplicationController

  def search
    @searchTerm = params[:search]
    if @searchTerm != nil
      @films = Film.search(@searchTerm)
    else
      @films = Film.sorted
    end

    #prep the thumbnail api
    VideoInfo.provider_api_keys = {youtube: 'AIzaSyCrG_E9dkX5wjXvjZqzGlWNCXm7VHfi3eY'}
  end

  def view
    @film = Film.find(params[:id])
  end

  def add
    @film = Film.new({:title => "Movie Title", :year => Time.now.year})
    @trivia_code = render_to_string(:partial => "application/trivia_field", :formats => [:html], :layout => false).gsub!("\n", "\\\n" ).gsub!('"', "'").gsub!('&quot;', '"')
    @role_code = render_to_string(:partial => "film/role_field", :formats => [:html], :layout => false, :locals => {:filmmaker_id => "filmmaker_id"}).gsub!("\n", "\\\n" ).gsub!('"', "'").gsub!('&quot;', '"')
  end

  def remove
    @film = Film.find(params[:id])
  end

  def edit
    @film = Film.find(params[:id])
    @trivia_code = render_to_string(:partial => "application/trivia_field", :formats => [:html], :layout => false).gsub!("\n", "\\\n" ).gsub!('"', "'").gsub!('&quot;', '"')
    @role_code = render_to_string(:partial => "film/role_field", :formats => [:html], :layout => false).gsub!("\n", "\\\n" ).gsub!('"', "'").gsub!('&quot;', '"')
  end

  #C(R)UD
  def create
    # Instantiate a new object using form parameters
    @film = Film.new(film_params)
    # Save the object
    if params[:trivia] != nil then
      # add empty trivia associated with @film
      #@film.trivia.build
      params[:trivia].each do |triv|
        if triv.length > 0 && triv != "" && triv != nil
          @film.trivia << Trivium.new(:body=>triv, :spoiler=>false)
        end
      end
    end
    if params[:roles] != nil && params[:roles][:filmmaker_id] != nil
        (0..params[:roles][:credit].length - 1).each do |i|
            if params[:roles][:filmmaker_id][i] != nil
                newRole = Role.new(:credit => params[:roles][:credit][i])
                @film.roles << newRole
                Filmmaker.find(params[:roles][:filmmaker_id][i]).roles << newRole
            end
        end
    end
    if @film.save
        @film.trivia.each do |triv|
            triv.save
        end
        @film.roles.each do |role|
            role.save
        end
     # If save succeeds, redirect to the index action
     flash[:notice] = "Film created successfully."
     redirect_to(:action => 'view', :id => @film.id)
     return
    #else
     # If save fails, redisplay the form so user can fix problems
     #render('add')
    end
    render('add')
  end

  def update
    # Find an existing object using form parameters
    @film = Film.find(params[:id])

    #update the trivia
    if params[:trivia] != nil || !@film.trivia.empty?;
        #a less than ideal way to update them
        @film.trivia.each do |triv|
            triv.destroy
        end
        @film.trivia.clear

        if params[:trivia] != nil && params[:trivia].length > 0
            params[:trivia].each do |triv|
                @film.trivia << Trivium.new(:body=>triv, :spoiler=>false);
            end
        end
    end

    if params[:roles] != nil || !@film.roles.empty?;
        #a less than ideal way to update them
        @film.roles.each do |role|
            role.destroy
        end
        @film.roles.clear

        if params[:roles] != nil && params[:roles][:filmmaker_id] != nil
            (0..params[:roles][:credit].length - 1).each do |i|
                if params[:roles][:filmmaker_id][i] != nil
                    newRole = Role.new(:credit => params[:roles][:credit][i])
                    @film.roles << newRole
                    Filmmaker.find(params[:roles][:filmmaker_id][i]).roles << newRole
                end
            end
        end
    end
    # Update the object
    if @film.update_attributes(film_params)
        @film.trivia.each do |triv|
            triv.save
        end
        @film.roles.each do |role|
            role.save
        end
        # If update succeeds, redirect to the index action
        flash[:notice] = "Film updated successfully."
        redirect_to(:action => 'view', :id => @film.id)
        return
        #else
        # If update fails, redisplay the form so user can fix problems
        #  render('edit')
    end
    render('edit')
  end

  def destroy
    film = Film.find(params[:id])
    film.trivia.each do |triv|
        triv.destroy
    end

    film.roles.each do |role|
        role.destroy
    end
    film.destroy
    flash[:notice] = "#{film.title} (#{film.year}) destroyed successfully."
    redirect_to(:action => 'search')
  end

  private
  def film_params
    # same as using "params[:subject]", except that it:
    # - raises an error if :subject is not present
    # - allows listed attributes to be mass-assigned
    params.require(:film).permit(:title, :year, :synopsis, :url, :password)
  end

end
