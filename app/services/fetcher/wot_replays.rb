# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

module Fetcher
  class WotReplays
    attr_reader :tank, :tank_external_id, :source, :page

    BASE_URL = 'http://wotreplays.ru'
    PAGE_LIMIT = 10

    def initialize(tank:)
      @tank             = tank
      @tank_external_id = tank.wot_replays_external.external_id
      @source           = 0
      @page             = 1
    end

    def call
      loop do
        break if page > PAGE_LIMIT
        break unless read_page

        @page += 1
      end
    end

    private

    def read_page
      Nokogiri::HTML(URI.open(page_url)).css('ul.r_list > li.clearfix').each do |item|
        @item             = item
        @link_for_details = link_for_battle_details
        next unless @link_for_details

        @external_id = battle_external_id
        break if BattleResult.find_by(external_id: @external_id)

        summary_info_block
        BattleResult.create!(battle_result_params)
      end
    end

    def page_url
      "#{BASE_URL}/site/index/version/83/tank/#{tank_external_id}/sort/uploaded_at.desc/page/#{page}/"
    end

    def link_for_battle_details
      @item.css('.r-map_85')[0]['href']
    end

    def battle_external_id
      @link_for_details.split('#')[0].split('/')[-1]
    end

    def summary_info_block
      info = Nokogiri::HTML(URI.open("#{BASE_URL}#{@link_for_details}"))
      @title = info.css('.replay-stats__title')[0]
      @date = info.css('.replay-stats__timestamp')[0]
      @medal_info_block = info.css('.replay-stats__medals tbody > tr:nth-of-type(1) > td:nth-of-type(1) img')
      @stun = stun_info(info)
    end

    def battle_result_params
      {
        killed_amount: battle_result_param(1),
        experience:    battle_result_param(2),
        damage:        battle_result_param(4),
        assist:        battle_result_param(5),
        block:         battle_result_param(6),
        stun:          @stun,
        tank:          tank,
        source:        source,
        medal:         @medal_info_block.empty? ? nil : medal_info,
        win:           @title ? @title.content == BattleResult::WIN_TITLE : false,
        date:          @date.nil? ? '' : Date.parse(@date.content),
        external_id:   @external_id
      }
    end

    def battle_result_param(index)
      @item.css(".r-info .r-info_ri li:nth-of-type(#{index})")[0].content.to_i
    end

    def medal_info
      case @medal_info_block[0]['title']
      when BattleResult::MASTER_GRADE then 3
      when BattleResult::FIRST_GRADE then 2
      when BattleResult::SECOND_GRADE then 1
      when BattleResult::THIRD_GRADE then 0
      end
    end

    def stun_info(info)
      content = info.css('.replay-stats__summary_effective')[6].content
      content == '-' ? 0 : content.to_i
    end
  end
end
