class TagsController < ActionController::Base
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  def index
    render json: Tag.all
  end

  def show
    render json: @tag
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name, :image_url);
  end

end
