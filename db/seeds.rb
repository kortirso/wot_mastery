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
