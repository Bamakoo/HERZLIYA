const colors = require('tailwindcss/colors')
/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{js,ts,jsx,tsx,vue}'],
  theme: {
    extend: {},
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
      },
      ...colors
    },
    fontFamily: { courrier: 'Courier New' }
  },
  plugins: []
}
