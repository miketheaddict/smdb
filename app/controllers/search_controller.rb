class SearchController < ApplicationController
  def search
      redirect_to(:controller=>params[:category], :action=>'search', :search=>params[:search])
  end
end
