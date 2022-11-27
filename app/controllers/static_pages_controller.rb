class StaticPagesController < ApplicationController
  def home
    @towns = Town.all
  end
end

