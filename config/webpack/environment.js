const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

environment.plugins.append(
  'Provide',
  new webpack.ProvidePlugin({
    process: 'process/browser',
    Buffer: ['buffer', 'Buffer']
  })
)

environment.config.merge({
  resolve: {
    fallback: {
      buffer: require.resolve('buffer/'),
      process: require.resolve('process/browser'),
      dgram: false,
      fs: false,
      net: false,
      tls: false,
      child_process: false
    }
  },
  node: {
    global: true,
    __filename: true,
    __dirname: true
  }
})

environment.config.delete('node.dgram')
environment.config.delete('node.fs')
environment.config.delete('node.net')
environment.config.delete('node.tls')
environment.config.delete('node.child_process')


module.exports = environment
