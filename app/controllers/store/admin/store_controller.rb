class Store::Admin::StoreController < ApplicationController
  def edit
    @store = Store.find_by(slug: params[:store_slug])
  end

  def update
    @store = Store.find_by(slug: params[:store_slug]
    @store.update(store_params)
    if @store.save
      redirect_to store_admin_path(@store.slug)
    else
      render :edit
    end
  end

  private

  def store_params
    params[:slug] = params[:store][:name].parameterize
    params.require(:store).permit(:name, :slug)
  end


end
