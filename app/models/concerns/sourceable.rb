# frozen_string_literal: true

module Sourceable
  extend ActiveSupport::Concern

  WOT_REPLAYS = 'wot_replays'

  included do
    enum source: { WOT_REPLAYS => 0 }
  end
end
