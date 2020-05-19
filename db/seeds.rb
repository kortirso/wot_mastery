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

countries = Country.pluck(:name, :id).inject({}) { |acc, element| acc.merge(element[0]['en'] => element[1]) }

tanks_json = JSON.parse(File.read(Rails.root.join('db/data/tanks.json')))
tanks_json.each do |tank_json|
  tank = Tank.find_by(name: tank_json.dig('tank', 'name'))
  next if tank

  country_id = countries[tank_json.dig('country', 'name')]
  tank = Tank.create(tank_json.fetch('tank').merge(country_id: country_id))
  tank.tank_externals.create(tank_json.fetch('external'))
end
