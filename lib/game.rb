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

  attr_reader :round, :name, :host

  protected

  attr_writer :round, :name, :host

  private

  def results
    builds.map { |b| b['result'] }
  end

  def builds
    JSON.parse(open("#{host}/job/#{name}/api/json").read)['builds'].first(round).map { |b| to_build(b['number']) }
  end

  def to_build(build_number)
    JSON.parse(open("#{host}/job/#{name}/#{build_number}/api/json").read)
  end


end
