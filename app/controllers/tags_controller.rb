class TagsController < ApplicationController
  before_action :authenticate_user! 
  before_action :tag_params, only: %i(destroy)

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)  
    if find_tag
      flash[:alert] = 'Already exist' 
      redirect_to new_tag_path
      return 
    end 
    
    @tag.user = current_user 
    if @tag.save
      flash[:notice] = 'New tag added!'
      redirect_to home_index_path  
    else 
      flash[:alert] = 'cannot be added'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @tag.destroy 
    flash[:notice] = 'Tag destroyed!' 
    redirect_to home_path
  end

  private 
    def tag_params
      params.require(:tag).permit(:name)
    end

    def set_tag 
      @tag = Tag.find(params[:id])
    end

    def find_tag 
      current_user.tags.find_by_name(tag_params[:name])
    end
end
