class Store::Manager::ItemsController < ApplicationController

  def index
    @items = Store.find_by_slug(params["store_slug"]).items
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    if @item.save
      redirect_to store_manager_items_path(@item.store.slug)
    else
      render :edit
    end
  end

  def new
    @item = Item.new
  end

  def create
    store = Store.find_by(slug: params[:store_slug])
    @item = store.items.new(item_params)
    if @item.save
      redirect_to store_manager_items_path(@item.store.slug)
    else
      render :new
    end
  end

  private

    def item_params
      params.require(:item).permit(:title, :description, :price, :image, :category_id)
    end

end
