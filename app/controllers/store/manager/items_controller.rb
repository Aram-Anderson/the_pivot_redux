class Store::Manager::ItemsController < ApplicationController
  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    if @item.save
      redirect_to store_admin_path(@store.slug)
    else
      render :edit
    end
  end

  private

    def item_params
      params.require(:item).permit(:title, :description, :price, :image, :category_id)
    end

end
