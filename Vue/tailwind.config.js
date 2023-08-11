/** @type {import('tailwindcss').Config} */
const colors = require('tailwindcss/colors')
module.exports = {
  content: ['./index.html', './src/**/*.{vue,js,ts,jsx,tsx}'],
  theme: {
    extend: {
      colors: {
        ...colors
      }
    },
    colors: {
      primary: {
        light: '#C5E2D6',
        DEFAULT: '#8BC6AE',
        dark: '#466357'
      },
      secondary: {
        light: '#CBD0EC',
        DEFAULT: '#97A1DA',
        medium: '#7280BB',
        dark: '#4C516D'
      }
    }
  },
  plugins: [require('@tailwindcss/forms')]
}
