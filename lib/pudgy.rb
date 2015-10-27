require "pudgy/version"
require 'delegate'

module Pudgy
  def self.consume rep, options
    Consumer.new(options.fetch(:parser)).parse rep
  end

  class Consumer < SimpleDelegator
  end
end
