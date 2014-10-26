class TagsController < ActionController::Base
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  def index
    if params['user_id']
      tags = Tag.where(user_id: params['user_id'])
    else
      tags = Tag.all
    end
    render json: tags, status: 200
  end

  def show
    render json: @tag, status: 200
  end

  def create
    tag = Tag.new(tag_params)
    tag.save
    render json: tag, status: 201
  end

  def update
    @tag.update_attributes(tag_params)
    render json: @tag, status: 200
  end

  def destoy
    @tag.destroy
    render json: @tag, status: 204
  end

  private

  def set_tag
    begin
    @tag = Tag.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { message: "Not Found", status: 404 }, status: 404
    end
  end

  def tag_params
    params.require(:tag).permit(:name);
  end

end
