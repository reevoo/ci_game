require 'spec_helper'
require 'game_email'

describe GameEmail do
  let(:game) { double(name: 'flakey-app', round: 7, host: 'http://ci-server') }
  let(:to) { ['ed@reevoo.com'] }

  subject { described_class.new(game, to) }

  describe '#inform_of_win!' do

    it 'sends an email' do
      expect(Pony).to receive(:mail)
      subject.inform_of_win!
    end

    it 'mentions the name of the game in the subject' do
      allow(Pony).to receive(:mail) do |args|
        expect(args[:subject]).to include 'flakey-app'
      end
      subject.inform_of_win!
    end

    it 'mentions the round in the body' do
      allow(Pony).to receive(:mail) do |args|
        expect(args[:body]).to include '7'
      end
      subject.inform_of_win!
    end

    it 'mentions the jenkins url in the body' do
      allow(Pony).to receive(:mail) do |args|
        expect(args[:body]).to include 'http://ci-server'
      end
      subject.inform_of_win!
    end

    it 'is from the correct person' do
      allow(Pony).to receive(:mail) do |args|
        expect(args[:from]).to eq 'Jenkins <jenkins@ci>'
      end
      subject.inform_of_win!
    end

    it 'is to the correct people' do
      allow(Pony).to receive(:mail) do |args|
        expect(args[:to]).to eq ['ed@reevoo.com']
      end
      subject.inform_of_win!
    end
  end
end
