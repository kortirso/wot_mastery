# frozen_string_literal: true

class BattleResultsImportJob < ApplicationJob
  queue_as :default

  def perform
    BattleResult.sources.each do |source, _|
      fetcher = Fetcher.call(source: source)
      Tank.all.each do |tank|
        fetcher.new(tank: tank).call
      end
    end
  end
end
