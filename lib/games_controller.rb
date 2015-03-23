require 'game'
require 'yaml'
require 'pony'

module GamesController
  extend self

  def run_games
    games.each do |game|
      if game.round_complete?
        #email people
        Pony.mail(
          to: config['email_addresses'],
          subject: "Awesomes You Just leveled up in the #{game.name} CI Game",
          body: <<-EMAIL
            Hi There,

            I'm Jenkins your friendly local CI server. I am proud to announce you
            have just reached the giddying heights of level #{game.round} in
            the #{game.name} CI Game.

            This means that you have managed #{game.round} consecutive passing
            builds on the #{game.name} project.

            Don't believe it check it out #{config['jenkins_host']}/job/#{game.name}/

            May I now humbly suggest you all order a Pizza, or whatever you want
            to celebrate your fantastic success.

            Me, I'm off to build some software.

            Your Humble Servant,

            Mr Jenkins

            P.S. It gets quite lonely here in the server room, come and see me sometime.
          EMAIL
        )
        save_game(game)
      else
        #do nothing the next round has not yet started
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
