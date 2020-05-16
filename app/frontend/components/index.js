window.components = {}
const components = require.context('components', true, /_component\.js$/)
components.keys().forEach(components)
