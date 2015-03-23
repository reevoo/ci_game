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
    '{"builds": [ {"number":17}, {"number":15}, {"number":14}, {"number":13} ]}'
  end

  describe '#round_complete?' do
    context 'in the first round' do
      let(:round) { 1 }

      context 'when the build is passing' do
        before do
          allow(subject).to receive(:open)
            .with('http://jenkins-server/job/flake-app/17/api/json')
            .and_return(double(read: '{ "result": "SUCCESS" }'))
        end

        it 'is a completed round' do
          expect(subject.round_complete?).to be_truthy
        end
      end

      context 'when the build is failing' do
        before do
          allow(subject).to receive(:open)
            .with('http://jenkins-server/job/flake-app/17/api/json')
            .and_return(double(read: '{ "result": "NOT PASSING" }'))
        end

        it 'is not a completed round' do
          expect(subject.round_complete?).to be_falsy
        end
      end
    end

    context 'in the second round' do
      let(:round) { 2 }

      context 'when one of the builds is passing' do
        before do
          allow(subject).to receive(:open)
            .with('http://jenkins-server/job/flake-app/17/api/json')
            .and_return(double(read: '{ "result": "SUCCESS" }'))

          allow(subject).to receive(:open)
            .with('http://jenkins-server/job/flake-app/15/api/json')
            .and_return(double(read: '{ "result": "OH NOES" }'))
        end

        it 'is not a completed round' do
          expect(subject.round_complete?).to be_falsy
        end
      end

      context 'both builds are failing' do
        before do
          allow(subject).to receive(:open)
            .with('http://jenkins-server/job/flake-app/17/api/json')
            .and_return(double(read: '{ "result": "NOT PASSING" }'))

          allow(subject).to receive(:open)
            .with('http://jenkins-server/job/flake-app/15/api/json')
            .and_return(double(read: '{ "result": "ALSO BORKED" }'))
        end

        it 'is not a completed round' do
          expect(subject.round_complete?).to be_falsy
        end
      end

      context 'both builds are passing' do
        before do
          allow(subject).to receive(:open)
            .with('http://jenkins-server/job/flake-app/17/api/json')
            .and_return(double(read: '{ "result": "SUCCESS" }'))

          allow(subject).to receive(:open)
            .with('http://jenkins-server/job/flake-app/15/api/json')
            .and_return(double(read: '{ "result": "SUCCESS" }'))
        end

        it 'is a completed round' do
          expect(subject.round_complete?).to be_truthy
        end
      end
    end

    context 'in the forth round' do
      let(:round) { 4 }

      context '4 builds are passing' do
        before do
          allow(subject).to receive(:open)
            .and_return(
            build_double('SUCCESS'),
            build_double('SUCCESS'),
            build_double('SUCCESS'),
            build_double('SUCCESS'),
          )

          allow(subject).to receive(:open)
            .with('http://jenkins-server/job/flake-app/api/json')
            .and_return(double(read: jobs_json))
        end

        it 'is a completed round' do
          expect(subject.round_complete?).to be_truthy
        end
      end

      context 'the last build failing' do
        before do
          allow(subject).to receive(:open)
            .and_return(
            build_double('SUCCESS'),
            build_double('SUCCESS'),
            build_double('SUCCESS'),
            build_double('FAIL'),
          )

          allow(subject).to receive(:open)
            .with('http://jenkins-server/job/flake-app/api/json')
            .and_return(double(read: jobs_json))
        end

        it 'is not a completed round' do
          expect(subject.round_complete?).to be_falsy
        end
      end

      def build_double(result)
        double(read: "{ \"result\": \"#{result}\" }")
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
