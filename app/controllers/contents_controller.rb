class ContentsController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_content, only: %i[show edit update destroy]

  def index
    @contents = current_user.contents 
    tag_names = params[:tags]

    if tag_names.present?
      @contents = @contents.joins(:tags).where(tags: { name: tag_names }).distinct
    end
  end

  def show
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
  end
  
  def new 
    @content = Content.new 
    @tags = current_user.tags.all  
  end

  def create
    @content = current_user.contents.build(content_params)
    
    if @content.save 
      process_tags!
      redirect_to contents_path, notice: 'Content successfully created!'
    else
      render :new, status: :unprocessable_entity
    end

  end

  def edit; end

  def update 
    if @content.update(content_params)
      process_tags!
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
  def content_params 
    # params.require(:content).permit!
    params.require(:content).permit(:title, :description)
  end
  
  def set_content
    @content = Content.find(params[:id])
  end
  
  def tags_params
    params.require(:content).permit(tags: [])[:tags].reject(&:blank?)
  end

  def process_tags!
    tags = tags_params.map do |tag_name|
      current_user.tags.where(name: tag_name).first_or_initialize
    end
    @content.tags = tags
  end
end
