class ContentsController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_content, only: %i[show edit update destroy]
  before_action :all_tags, only: [:edit, :new]

  def index
    @contents = current_user.contents 
  end

  def show; end
  
  def new 
    @content = Content.new  
  end

  def create
    @content = current_user.contents.build(content_params)
    
    if @content.save 
      process_tag!
      redirect_to contents_path, notice: 'Content successfully created!'
    else
      render :new, status: :unprocessable_entity
    end

  end

  def edit; end

  def update 
    if @content.update(content_params)
      process_tag!
      redirect_to contents_path, notice: 'Content successfully updated!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy 
    @content.destroy 
    redirect_to contents_path, notice: 'Content successfully removed!'
  end

  private 

    def tag_params
      params.require(:content).permit(tags: [])[:tags].reject(&:blank?) 
    end

    def content_params 
      params.require(:content).permit(:title, :description)
    end

    def set_content
      @content = Content.find(params[:id])
    end

    def all_tags
      @tags = current_user.tags.all
    end

    def process_tag!
      tags = tag_params.map do |tag_name|
        current_user.tags.where(name: tag_name).first_or_initialize
      end
      @content.tags = tags
    end
end
