class CollectionsController < ActionController::Base
  before_action :set_collection, only: [:show, :edit, :update, :destroy]

  def index
    if params[:user_id]
      collections = Collection.where(user_id: params[:user_id])
      render json: collections, status: 200
    else
      render json: { message: "Give an user_id", status: 202 }, status: 202
    end
  end

  def show
    render json: @collection, status: 200
  end

  def create
    collection = Collection.new(collection_params)
    collection.save
    render json: collection, status: 201
  end

  def update
    @collection.update_attributes(collection_params)
    render json: @collection, status: 200
  end

  def destoy
    @collection.destroy
    render json: @collection, status: 204
  end

  private

  def set_collection
    begin
      @collection = Collection.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { message: "Not Found", status: 404 }, status: 404
    end
  end

  def collection_params
    params.require(:collection).permit(:name, :image_url);
  end

end
