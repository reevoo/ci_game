require 'open-uri'
require 'json'

class Game
  def initialize(round, host, name)
    self.round = round
    self.host = host
    self.name = name
  end


  def round_complete?
    results.all? { |r| r == 'SUCCESS' }
  end

  attr_reader :round, :name

  protected

  attr_accessor :host
  attr_writer :round, :name

  private

  def results
    builds.map { |b| b['result'] }
  end

  def builds
    JSON.parse(open("#{host}/job/#{name}/api/json").read)['builds'].map { |b| to_build(b['number']) }.first(round)
  end

  def to_build(build_number)
    JSON.parse(open("#{host}/job/#{name}/#{build_number}/api/json").read)
  end


end
