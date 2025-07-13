class StaticPagesController < ApplicationController
  def top
    @items = Item.all
  end

  def terms
  end

  def privacy
  end
end
