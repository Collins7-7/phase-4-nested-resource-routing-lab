class ItemsController < ApplicationController

  def index
    if params[:user_id] == true
      user = User.find(params[:user_id])
      items = user.items
      render json: items, include: :user
    elsif params[:user_id] == false
      render json: {error:"User not found"}, status: :not_found
    else
    items = Item.all
    render json: items, include: :user, status: :not_found
    end
  end

  def show
    item = Item.find_by(id: params[:id])
    if item
      render json: item, include: :user
    else
      render json:{error: 'Item not found'}, status: :not_found
    end
  end

  def create
    item = Item.create(item_params)
    render json: item, status: :created

  end

  private

  def item_params
    params.permit(:name, :description, :price, :user_id)
  end

end
