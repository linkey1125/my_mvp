class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  def index
    @items = Item.all

    @items = @items.where(uv_cut_rate: params[:uv_cut_rate]) if params[:uv_cut_rate].present?
    @items = @items.where(category: params[:category]) if params[:category].present?
    @items = @items.where(price_range: params[:price_range]) if params[:price_range].present?

    render json: { search_results: @items }
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      render json: { message: '投稿完了', item: @item }, status: :created
    else
      render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @item = current_user.items.find(params[:id])
    if @item.update(item_params)
      render json: { message: '編集完了', item: @item }
    else
      render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @item = current_user.items.find(params[:id])
    @item.destroy
    render json: { message: '削除完了' }
  end

  private

  def item_params
    params.require(:item).permit(:image, :uv_cut_rate, :category, :price_range)
  end
end
