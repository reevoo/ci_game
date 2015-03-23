require 'pony'

class GameEmail
  def initialize(game, to)
    self.game = game
    self.to = to
  end

  def inform_of_win!
    Pony.mail(
      to: to,
      from: 'Jenkins <jenkins@ci>',
      subject: "Awesomes You Just leveled up in the #{game.name} CI Game",
      body: winning_body,
    )
  end

  protected

  attr_accessor :game, :to

  private

  def winning_body # rubocop:disable Metrics/MethodLength
    <<-BODY
    Hi There,

    I'm Jenkins your friendly local CI server. I am proud to announce you
    have just reached the giddying heights of level #{game.round} in
    the #{game.name} CI Game.

    This means that you have managed #{game.round} consecutive passing
    builds on the #{game.name} project.

    Don't believe it check it out #{game.host}/job/#{game.name}/

    May I now humbly suggest you all order a Pizza, or whatever you want
    to celebrate your fantastic success.

    Me, I'm off to build some software.

    Your Humble Servant,

    Mr Jenkins

    P.S. It gets quite lonely here in the server room, come and see me sometime.
    BODY
  end
end
