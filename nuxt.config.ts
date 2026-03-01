// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  modules: [
    '@nuxt/eslint',
    '@nuxt/ui',
    '@nuxt/image',
    '@nuxt/icon',
    '@nuxt/scripts',
    '@nuxt/content',
    '@pinia/nuxt',
    '@nuxt/hints',
    '@vueuse/nuxt',
    '@formkit/auto-animate',
    '@nuxtjs/i18n',
  ],

  devtools: {
    enabled: true,
  },

  css: ['~/assets/css/main.css',],

  routeRules: {
    '/': {prerender: true,},
  },

  compatibilityDate: '2026-01-15',

  eslint: {
    config: {
      stylistic: {
        commaDangle: 'only-multiline',
        braceStyle: '1tbs',
      },
    },
  },

  i18n: {
    defaultLocale: 'en',
    locales: [
      {code: 'en', name: 'English', file: 'en.ts',},
      {code: 'ru', name: 'Русский', file: 'ru.ts',},
    ],
    strategy: 'no_prefix',
  },
},)
