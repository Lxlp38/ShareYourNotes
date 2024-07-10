class PagesController < ApplicationController
  def home
    @notes = Note.all
  end
end
