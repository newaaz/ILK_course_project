class StaticPagesController < ApplicationController
  def home
    @towns = Town.all
  end

  def contacts
  end

  def about
  end

  def privacy
  end
end

