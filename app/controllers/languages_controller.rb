class LanguagesController < ApplicationController
  
  def create
    @language = current_user.languages.new(:title => params[:title])
    @language.save
  end

  def destroy
    @language = Language.find(params[:id])
    @language.destroy
  end
end