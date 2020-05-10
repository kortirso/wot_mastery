# frozen_string_literal: true

module Fetcher
  REGISTERED_SOURCES = {
    Sourceable::WOT_REPLAYS => WotReplays
  }.freeze

  def self.call(tank:)
    REGISTERED_SOURCES.each_value do |source|
      "Fetcher::#{source}".constantize.new(tank: tank).call
    end
  end
end
