const autoprefixer = require('autoprefixer');
const { default: postcss } = require('postcss');
var tailwindcss = require('tailwindcss');

module.exports = {
    plugins: [
      tailwindcss('./app/javascript/stylesheets/tailwind.config.js'),
      require ('autoprefixer'),
      require('postcss-import'), 
      require('postcss-flexbug-fixes'),
      require('postcss-preset-environments')({
      autoprefixer: {
          flexbox: 'no-2009'
      },
      stage:3
    })
    ]
  }
  