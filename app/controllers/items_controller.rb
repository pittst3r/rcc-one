class ItemsController < ApplicationController

  def index
    @items = Item.all
    respond_to do |format|
      format.html
      format.json { render json: { items: @items } }
    end
  end

end
