class PerspectivesController < ApplicationController
  before_filter :require_login

  def index
    @user = current_user
    @perspective = Perspective.new
    @sp = @user.saved_perspectives.collect(&:perspective_id)
    @perspectives = Perspective.where("user_id = ? or id in (?)", @user.id, @sp).order("created_at desc")
    @perspectives = @perspectives.paginate(:page => params[:page], :per_page => 20)

    @user_perspectives = @user.perspectives
    @good_view_count = @user_perspectives.where(:story_type => "The Good").sum(&:viewed)
    @bad_view_count = @user_perspectives.where(:story_type => "The Bad").sum(&:viewed)
    @ugly_view_count = @user_perspectives.where(:story_type => "The Ugly").sum(&:viewed)
    @good_saved_count = @user_perspectives.where(:story_type => "The Good").sum(&:saved)
    @bad_saved_count = @user_perspectives.where(:story_type => "The Bad").sum(&:saved)
    @ugly_saved_count = @user_perspectives.where(:story_type => "The Ugly").sum(&:saved)
  end

  def create
    @user = current_user
    if params[:perspective].present?
      @perspective = @user.perspectives.new(params[:perspective])
      @perspective.save
      if params[:keywords].present?
        keywords = params[:keywords].split(",")
        keywords.each do |keyword|
          PerspectiveTag.create(:perspective_id => @perspective.id, :name => keyword).save
        end
      end
    end
    redirect_to perspectives_path, :notice => "Your story has been added"
  end

  def save
    #cancan
    @perspective = Perspective.find(params[:id])
    @saved_perspective = current_user.saved_perspectives.build(:perspective_id => @perspective.id)
    if @saved_perspective.save
      @perspective.saved_counter
    else
      render :nothing => true
    end
  end

  def good
    @perspectives = Perspective.where(:story_type => "The Good")
    @perspectives = @perspectives.paginate(:page => params[:page], :per_page => 20)
  end

  def bad
  	@perspectives = Perspective.where(:story_type => "The Bad")
    @perspectives = @perspectives.paginate(:page => params[:page], :per_page => 20)
  end

  def ugly
  	@perspectives = Perspective.where(:story_type => "The Ugly")
    @perspectives = @perspectives.paginate(:page => params[:page], :per_page => 20)
  end
end