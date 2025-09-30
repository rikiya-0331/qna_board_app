/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/views/**/*.html.{erb,haml,slim}',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/javascript/**/*.ts',
    './app/javascript/**/*.jsx',
    './app/javascript/**/*.tsx',
    './app/assets/stylesheets/**/*.css',
    './app/components/**/*.{erb,haml,slim,rb}',
  ],
  safelist: [
    'bg-gray-800',
    'text-white',
    'p-4',
    'shadow-md',
    'text-2xl',
    'font-bold'
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}