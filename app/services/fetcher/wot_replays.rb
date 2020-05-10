# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

module Fetcher
  class WotReplays
    attr_reader :tank, :external_id, :source, :page

    BASE_URL = 'http://wotreplays.ru'

    def initialize(tank:)
      @tank        = tank
      @external_id = tank.wot_replays_external.external_id
      @source      = 0
      @page        = 1
    end

    def call
      while page <= 10
        read_page
        @page += 1
      end
    end

    private

    def read_page
      Nokogiri::HTML(URI.open(page_url)).css('.r_list.initial > li.clearfix').each do |item|
        @item = item
        next if BattleResult.find_by(external_id: battle_result_external_id)

        BattleResult.create!(battle_result_params)
      end
    end

    def page_url
      "#{BASE_URL}/site/index/version/83/tank/#{external_id}/sort/uploaded_at.desc/page/#{page}/"
    end

    def battle_result_external_id
      @battle_result_external_id ||= link_for_details.split('#')[0].split('/')[-1]
    end

    def link_for_details
      @link_for_details ||= @item.css('.r-map_85')[0]['href']
    end

    def medal_info_block
      return @medal_info_block if @medal_info_block

      info = Nokogiri::HTML(URI.open("#{BASE_URL}#{@link_for_details}"))
      @medal_info_block = info.css('.replay-stats__medals tbody > tr:nth-of-type(1) > td:nth-of-type(1) img')
    end

    def battle_result_params
      {
        experience: battle_result_param(2),
        damage:     battle_result_param(4),
        assist:     battle_result_param(5),
        block:      battle_result_param(6),
        tank:       tank,
        source:     source,
        medal:      medal_info_block.empty? ? nil : medal_info
      }
    end

    def battle_result_param(index)
      @item.css(".r-info .r-info_ri li:nth-of-type(#{index})")[0].content.to_i
    end

    def medal_info
      case medal_info_block[0]['title']
      when 'Мастер' then 3
      when '1 класс' then 2
      when '2 класс' then 1
      when '3 класс' then 0
      end
    end
  end
end
