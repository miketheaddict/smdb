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
    @trivia_code = render_to_string(:partial => "application/trivia_field", :formats => [:html], :layout => false).gsub!("\n", "\\\n" ).gsub!('"', "'").gsub!('&quot;', '"')
    @role_code = render_to_string(:partial => "filmmaker/role_field", :formats => [:html], :layout => false).gsub!("\n", "\\\n" ).gsub!('"', "'").gsub!('&quot;', '"')
  end

  def remove
    @filmmaker = Filmmaker.find(params[:id])
  end

  def edit
    @filmmaker = Filmmaker.find(params[:id])
    @trivia_code = render_to_string(:partial => "application/trivia_field", :formats => [:html], :layout => false).gsub!("\n", "\\\n" ).gsub!('"', "'").gsub!('&quot;', '"')
    @role_code = render_to_string(:partial => "filmmaker/role_field", :formats => [:html], :layout => false).gsub!("\n", "\\\n" ).gsub!('"', "'").gsub!('&quot;', '"')
  end

  #C(R)UD
  def create
    # Instantiate a new object using form parameters
    @filmmaker = Filmmaker.new(filmmaker_params)
    # Save the object

    if params[:trivia] != nil then
      # add empty trivia associated with @film
      #@film.trivia.build
      params[:trivia].each do |triv|
        if triv.length > 0 && triv != "" && triv != nil
          @filmmaker.trivia << Trivium.new(:body=>triv, :spoiler=>false)
        end
      end
    end
    if params[:roles] != nil && params[:roles][:film_id] != nil
        (0..params[:roles][:credit].length - 1).each do |i|
            if params[:roles][:film_id][i] != nil
                newRole = Role.new(:credit => params[:roles][:credit][i])
                @filmmaker.roles << newRole
                Film.find(params[:roles][:film_id][i]).roles << newRole
            end
        end
    end

    if @filmmaker.save
        @filmmaker.trivia.each do |triv|
            triv.save
        end

        @filmmaker.roles.each do |role|
            role.save
        end
        # If save succeeds, redirect to the index action
        flash[:notice] = "Filmmaker added successfully."
        redirect_to(:action => 'view', :id => @filmmaker.id)
        return
    end
    render('add')
  end

  def update
    # Find an existing object using form parameters
    @filmmaker = Filmmaker.find(params[:id])

    if params[:trivia] != nil || !@filmmaker.trivia.empty?;
        #a less than ideal way to update them
        @filmmaker.trivia.each do |triv|
            triv.destroy
        end
        @filmmaker.trivia.clear

        if params[:trivia] != nil && params[:trivia].length > 0
            params[:trivia].each do |triv|
                @filmmaker.trivia << Trivium.new(:body=>triv, :spoiler=>false);
            end
        end
    end


    if params[:roles] != nil || !@film.roles.empty?;
        #a less than ideal way to update them
        @filmmaker.roles.each do |role|
            role.destroy
        end
        @filmmaker.roles.clear

        if params[:roles] != nil
            (0..params[:roles][:credit].length - 1).each do |i|
                if params[:roles][:film_id][i] != nil
                    newRole = Role.new(:credit => params[:roles][:credit][i])
                    @filmmaker.roles << newRole
                    Film.find(params[:roles][:film_id][i]).roles << newRole
                end
            end
        end
    end

    # Update the object
    if @filmmaker.update_attributes(filmmaker_params)

        @filmmaker.roles.each do |role|
            role.save
        end
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
    filmmaker.trivia.each do |triv|
        triv.destroy
    end

    filmmaker.roles.each do |role|
        role.destroy
    end
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
