class CollectionsController < ActionController::Base
  before_action :set_collection, only: [:show, :edit, :update, :destroy]
  before_action :collection_params, only: [:show, :create, :update, :destroy]

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
    if params[:encoded_image_data]
      decode_image_data
    end
    collection = Collection.new(@collection_params)
    collection.save
    if @collection.save
      render json: collection, status: 201
    else
      render json: collection, status: 400
    end
  end

  def update
    @collection.update_attributes(@collection_params)
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
    @collection_params = params.require(:collection).permit(:name, :image_url, :user_id, :image);
  end

  def decode_image_data
    # decode base64 string
    Rails.logger.info 'decoding now'
    decoded_data = Base64.decode64(params[:encoded_image_data])
    # create 'file' understandable by Paperclip
    data = StringIO.new(decoded_data)
    data.class_eval do
      attr_accessor :content_type, :original_filename
    end

    # set file properties
    data.content_type = params[:image_content_type] # json parameter set in directive scope
    data.original_filename = params[:image_path] # json parameter set in directive scope

    # update hash, I had to set @up to persist the hash so I can pass it for saving
    # since set_params returns a new hash everytime it is called (and must be used to explicitly list which params are allowed otherwise it throws an exception)
    @collection_params[:image] = data
    # image is the model attribute that i defined as an attachment using paperclip generator

    #decoded_file = Base64.decode64(params[:encoded_image])
    #begin
      #file = Tempfile.new(['test', '.jpg'])
      #file.binmode
      #file.write decoded_file
      #file.close
      #@collection.image = file
    #ensure
      #file.unlink
    #end

  end

end
