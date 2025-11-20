const { generateWebpackConfig } = require('shakapacker')
const customConfig = require('./environment')

module.exports = generateWebpackConfig(customConfig)
