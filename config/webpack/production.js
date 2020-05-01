process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const environment = require('./environment')

module.exports = environment.toWebpackConfig()

config.action_mailer.default_url_options = { :host => 'localhost:3000' }