class WelcomeController < ApplicationController
  def index
    @verse = VerseDecorator.decorate(Verse.random)
  end

  def about
  end
end
