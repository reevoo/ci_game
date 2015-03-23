require 'spec_helper'
require 'games_controller'

describe GamesController do
  before do
    File.write('config/config.yaml', YAML.dump(config))
  end

  after do
    File.delete('config/config.yaml')
  end

  let(:config) do
    {
      'jenkins_host' => host,
      'games' => %w(flake 99),
      'email_addresses' => ['ed@reevoo.com'],
    }
  end

  let(:host) { 'http://ci-foo' }
  let(:failing_game) { double(round_complete?: false) }
  let(:passing_game) { double(round_complete?: true, round: 1, name: 'flake') }
  let(:email) { double }

  before do
    allow(Game).to receive(:new).and_return(failing_game)
  end

  context 'before any games have been played' do
    it 'starts all the games on round one' do
      expect(Game).to receive(:new).with(
        1,
        host,
        'flake',
      ).and_return(failing_game)

      expect(Game).to receive(:new).with(
        1,
        host,
        '99',
      ).and_return(failing_game)

      described_class.run_games
    end

    context 'if a game passes' do

      it 'sends an email about that game, and saves the next round' do
        allow(Game).to receive(:new).with(
          1,
          host,
          'flake',
        ).and_return(passing_game)

        expect(GameEmail).to receive(:new).with(
          passing_game,
          ['ed@reevoo.com'],
        ).and_return(email)

        expect(email).to receive(:inform_of_win!)

        described_class.run_games

        allow(Game).to receive(:new).with(
          2,
          host,
          'flake',
        ).and_return(failing_game)

        described_class.run_games

      end

      after do
        File.delete('games/flake')
      end
    end
  end
end
