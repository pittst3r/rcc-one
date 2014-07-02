class ItemsController < ApplicationController

  def index
    @items = Item.all
    respond_to do |format|
      format.html
      format.json { render json: { items: @items } }
    end
  end

  def create
    @item = Item.create!(item_params)
    respond_to do |format|
      format.html { redirect_to :index }
      format.json { render status: 201, json: { item: @item } }
    end
  end

  def update
    @item = Item.find(params[:id]).tap { |i| i.update_attributes!(item_params) }
    respond_to do |format|
      format.html { redirect_to :index }
      format.json { render status: 200, json: { item: @item } }
    end
  end

  def destroy
    @item = Item.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to :index }
      format.json { render status: 200, json: { item: @item } }
    end
  end

  private

  def item_params
    params.require(:item).permit(:id, :content)
  end

end
