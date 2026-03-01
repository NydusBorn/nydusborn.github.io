<script setup lang="ts">
import {useRoute} from "vue-router";

const colorMode = useColorMode()

const color = computed(() => colorMode.value === 'dark' ? '#020618' : 'white')

useHead({
  meta: [
    {charset: 'utf-8'},
    {name: 'viewport', content: 'width=device-width, initial-scale=1'},
    {key: 'theme-color', name: 'theme-color', content: color}
  ],
  link: [
    {rel: 'icon', href: '/favicon.png'}
  ],
  htmlAttrs: {
    lang: useI18n().locale.value
  }
})

useSeoMeta({
  titleTemplate: `%s - ${$t('Site-Title')}`,
  ogImage: '/favicon.ico'
})

const route = useRoute()
const router = useRouter()
const lang = route.query.lang as string | undefined

const {locales, setLocale} = useI18n()

if (lang != '' && locales.value.map((x) => x.code).includes(lang)) {
  await setLocale(lang)
  await router.push(route.Path)
  reloadNuxtApp({
    force: true
  })
}

</script>

<template>
  <UApp>
    <NuxtLayout>
      <NuxtPage/>
    </NuxtLayout>
  </UApp>
</template>
