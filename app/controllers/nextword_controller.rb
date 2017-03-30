class NextwordController < ApplicationController
  def index

  #binding.pry

    @game = Game.all

    response = RestClient.post("https://strikingly-hangman.herokuapp.com/game/on", { sessionId: "695411788b93e8579d44255e1150cf80", action: "nextWord" }.to_json)

    data = JSON.parse(response.body)
    #binding.pry
    @word = data["data"]["word"]
    @totalWordCount = data["data"]["totalWordCount"]

    redirect_to guess_cities_path
  end




end
