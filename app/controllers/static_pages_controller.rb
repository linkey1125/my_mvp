class StaticPagesController < ApplicationController
  def top
    @items = Item.all
  end
end
