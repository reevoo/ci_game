require 'game'
require 'game_email'
require 'yaml'

module GamesController
  extend self

  def run_games
    games.each do |game|
      if game.round_complete?
        GameEmail.new(game, config['email_addresses']).inform_of_win!
        save_game(game)
      end
    end
  end

  private

  def games
    config['games'].map { |g| load_game(g) }
  end

  def save_game(game)
    next_round = game.round + 1
    File.write("games/#{game.name}", next_round.to_s)
  end

  def load_game(game)
    Game.new(round(game), config['jenkins_host'], game)
  end

  def round(game)
    File.read("games/#{game}").chomp.to_i
  rescue
    1
  end

  def config
    YAML.load(File.read('config/config.yaml'))
  end
end
