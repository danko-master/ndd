class MainsController < ApplicationController
  def show
    @main = Main.first
  end

  def edit
    @main = Main.first
  end

end
