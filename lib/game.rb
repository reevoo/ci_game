require 'open-uri'
require 'json'

class Game
  def initialize(round, host, name)
    self.round = round
    self.host = host
    self.name = name
  end


  def round_complete?
    num_successful_builds >= round
  end

  attr_reader :round, :name, :host

  protected

  attr_writer :round, :name, :host

  private

  def num_successful_builds
    build_number('lastSuccessfulBuild') - build_number('lastUnsuccessfulBuild')
  end

  def api_info
    @api_info ||= JSON.parse(open("#{host}/job/#{name}/api/json").read)
  end

  # Returns 0 if the build does not exist at the given key,
  # otherwise returns 'number'
  def build_number(key)
    build = api_info[key]
    return 0 if build.nil?

    build['number']
  end


end
