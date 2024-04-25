class TagsController < ApplicationController
  before_action :authenticate_user! 

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    @tag.user = current_user 
    binding.pry
    if @tag.save
      flash[:notice] = 'New tag added!'
      redirect_to home_path  
    else 
      flash[:alert] = 'cannot be added'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private 
    def tag_params
      params.require(:tag).permit(:name)
    end
end
