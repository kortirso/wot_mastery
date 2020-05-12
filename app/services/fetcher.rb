# frozen_string_literal: true

module Fetcher
  REGISTERED_SOURCES = {
    Sourceable::WOT_REPLAYS => Fetcher::WotReplays
  }.freeze

  def self.call(source:)
    REGISTERED_SOURCES.fetch(source)
  end
end
