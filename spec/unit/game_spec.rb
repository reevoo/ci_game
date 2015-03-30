require 'spec_helper'
require 'game'

describe Game do
  subject { described_class.new(round, 'http://jenkins-server', 'flake-app') }

  before do
    allow(subject).to receive(:open)
      .with('http://jenkins-server/job/flake-app/api/json')
      .and_return(double(read: jobs_json))
  end

  let(:jobs_json) do
    {}
  end

  def passing_build(number_of_passing_builds)
    {
      'lastSuccessfulBuild' => { 'number' => 100 },
      'lastUnsuccessfulBuild' => { 'number' => 100 - number_of_passing_builds },
    }.to_json
  end

  def failing_build(number_of_failing_builds)
    {
      'lastSuccessfulBuild' => { 'number' => 1 },
      'lastUnsuccessfulBuild' => { 'number' => 1 + number_of_failing_builds },
    }.to_json
  end

  describe '#round_complete?' do
    context 'in the first round' do
      let(:round) { 1 }

      context 'when the build is passing' do
        let(:jobs_json) { passing_build(1) }

        it 'is a completed round' do
          expect(subject.round_complete?).to be_truthy
        end
      end

      context 'when the build is failing' do
        let(:jobs_json) { failing_build(1) }

        it 'is not a completed round' do
          expect(subject.round_complete?).to be_falsy
        end
      end
    end

    context 'in the second round' do
      let(:round) { 2 }

      context 'when only one build passed' do
        let(:jobs_json) { passing_build(1) }

        it 'is not a completed round' do
          expect(subject.round_complete?).to be_falsy
        end
      end

      context 'when the last build is failing' do
        let(:jobs_json) { failing_build(1) }

        it 'is not a completed round' do
          expect(subject.round_complete?).to be_falsy
        end
      end

      context 'both builds are passing' do
        let(:jobs_json) { passing_build(2) }

        it 'is a completed round' do
          expect(subject.round_complete?).to be_truthy
        end
      end
    end

    context 'in the forth round' do
      let(:round) { 4 }

      context '4 builds are passing' do
        let(:jobs_json) { passing_build(4) }

        it 'is a completed round' do
          expect(subject.round_complete?).to be_truthy
        end
      end

      context 'the last build failing' do
        let(:jobs_json) { passing_build(3) }

        it 'is not a completed round' do
          expect(subject.round_complete?).to be_falsy
        end
      end
    end
  end

  describe 'boring attributes' do
    let(:round) { 7 }

    specify { expect(subject.round).to eq 7 }
    specify { expect(subject.name).to eq 'flake-app' }
    specify { expect(subject.host).to eq 'http://jenkins-server' }
  end
end
