class ItemsController < ActionController::Base
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    if params['collection_id']
      items = Item.where(collection_id: params['collection_id'])
      render json: items, status: 200
    else
      render json: { message: "Give an collection_id", status: 202 }, status: 202
    end
  end

  def show
    render json: @item, status: 200
  end

  def create
    item = Item.new(item_params)
    item.save
    render json: item, status: 201
  end

  def update
    @item.update_attributes(item_params)
    render json: @item, status: 200
  end

  def destoy
    @item.destroy
    render json: @item, status: 204
  end

  private

  def set_item
    begin
      @item = Item.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { message: "Not Found", status: 404 }, status: 404
    end
  end

  def item_params
    params.require(:item).permit(:name, :image_url);
  end

end
