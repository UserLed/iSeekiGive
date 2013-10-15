class LanguagesController < ApplicationController
  
  def create
    @language = current_user.languages.new(:name => params[:name])
    if @language.save
      @saved = true
    end
  end

  def destroy
    @language = Language.find(params[:id])
    @language.destroy
  end
end