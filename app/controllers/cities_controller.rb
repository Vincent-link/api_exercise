class CitiesController < ApplicationController
  protect_from_forgery prepend: true
  before_filter :authenticate_user!, :only => [:new, :create, :destroy, :edit]
  def index
  end

  def startgame
      response = RestClient.post("https://strikingly-hangman.herokuapp.com/game/on", { playerId: "liuhuijisuanji@gmail.com", action: "startGame" }.to_json)

      data = JSON.parse(response.body)

      Game.update(:sessionId => data["sessionId"])

      @sessionId = data["sessionId"]

      render :giveme
  end

  def nextword
  #binding.pry
    @game = Game.first
    @sessionId = @game.sessionId

    response = RestClient.post("https://strikingly-hangman.herokuapp.com/game/on",
    { sessionId: @sessionId, action: "nextWord" }.to_json)

    data = JSON.parse(response.body)
    #binding.pry

    @word = data["data"]["word"]
    @totalWordCount = data["data"]["totalWordCount"]
    @wrongGuessCountOfCurrentWord = data["data"]["wrongGuessCountOfCurrentWord"]

    render :showword
  end

  def guess
    @game = Game.first
    @sessionId = @game.sessionId
    params = {'guess' => '','submit' => 'Submit'}

    response = RestClient.post("https://strikingly-hangman.herokuapp.com/game/on", { sessionId: @sessionId, action: "guessWord", guess: "n" }.to_json)

    data = JSON.parse(response.body)
    #binding.pry
    @word = data["data"]["word"]
    @totalWordCount = data["data"]["totalWordCount"]
    @wrongGuessCountOfCurrentWord = data["data"]["wrongGuessCountOfCurrentWord"]

    render :guess
  end

  def getresult
  #binding.pry

    response = RestClient.post("https://strikingly-hangman.herokuapp.com/game/on", { sessionId: "695411788b93e8579d44255e1150cf80", action: "getResult"}.to_json)

    data = JSON.parse(response.body)
    #binding.pry
    @sessionId = data["sessionId"]
    @totalWordCount = data["data"]["totalWordCount"]
    @correctWordCount = data["data"]["correctWordCount"]
    @totalWrongGuessCount = data["data"]["totalWrongGuessCount"]
    @score = data["data"]["score"]

    render :getresult_show
  end

  def submit

    response = RestClient.post("https://strikingly-hangman.herokuapp.com/game/on", { sessionId: "695411788b93e8579d44255e1150cf80", action: "submitResult"}.to_json)

    data = JSON.parse(response.body)
    #binding.pry
    @message = data["message"]
    @sessionId = data["sessionId"]
    @totalWordCount = data["data"]["totalWordCount"]
    @correctWordCount = data["data"]["correctWordCount"]
    @totalWrongGuessCount = data["data"]["totalWrongGuessCount"]
    @score = data["data"]["score"]
    @date = data["data"]["date"]

    render :submit
  end


  private

  def cities_params
    params.require(:cities).permit(:sessionId)
  end

end
