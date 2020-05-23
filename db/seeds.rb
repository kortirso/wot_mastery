# frozen_string_literal: true

# rubocop: disable Style/WordArray
if Country.count.zero?
  [
    ['USSR', 'СССР'],
    ['Germany', 'Германия'],
    ['USA', 'США'],
    ['France', 'Франция'],
    ['UK', 'Великобритания'],
    ['China', 'Китай'],
    ['Poland', 'Польша'],
    ['Czechoslovakia', 'Чехословакия'],
    ['Japan', 'Япония'],
    ['Sweden', 'Швеция'],
    ['Italy', 'Италия']
  ].each do |country|
    Country.create(name: { 'en' => country[0], 'ru' => country[1] })
  end
end
# rubocop: enable Style/WordArray

types = []
types << Tanks::Type.find_or_create_by(name: 0, value: 'Light tanks')
types << Tanks::Type.find_or_create_by(name: 1, value: 'Medium tanks')
types << Tanks::Type.find_or_create_by(name: 2, value: 'Heavy tanks')
types << Tanks::Type.find_or_create_by(name: 3, value: 'Tank destroyers')
types << Tanks::Type.find_or_create_by(name: 4, value: 'SPGs')

countries = Country.pluck(:name, :id).inject({}) { |acc, element| acc.merge(element[0]['en'] => element[1]) }

tanks_json = JSON.parse(File.read(Rails.root.join('db/data/tanks.json')))
tanks_json.each do |tank_json|
  tank = Tank.find_by(name: tank_json.dig('tank', 'name'))
  next if tank

  country_id = countries[tank_json.dig('country', 'name')]
  type = types[tank_json.dig('tank', 'type')]
  attributes = tank_json
    .fetch('tank')
    .delete_if { |key, _| key == 'type' }
    .merge(country_id: country_id, tanks_type: type)

  tank = Tank.create(attributes)
  tank.tank_externals.create(tank_json.fetch('external'))
end
