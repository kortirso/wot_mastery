# frozen_string_literal: true

# rubocop: disable Style/WordArray
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
# rubocop: enable Style/WordArray

ussr = Country.find_by(name: { 'en' => 'USSR', 'ru' => 'СССР' })

is7 = Tank.create(name: { 'en' => 'IS-7', 'ru' => 'ИС-7' }, tier: 10, country: ussr, type: 2)
Tanks::External.create(tank: is7, source: 0, external_id: '364-1046')
