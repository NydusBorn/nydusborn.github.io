<script setup lang="ts">
import { withLeadingSlash, } from 'ufo'
import type { Collections, } from '@nuxt/content'

const route = useRoute()
const { locale, } = useI18n()
const slug = computed(() => Array.isArray(route.params.slug,) ? withLeadingSlash(String(route.params.slug.join('/',),),) : withLeadingSlash(String(route.params.slug,),),)

const { data: page, } = await useAsyncData('page-' + slug.value, async () => {

  let content = await queryCollection('content',).path(`/${locale.value}/tech${slug.value}`,).first()

  if (!content && locale.value !== 'en') {
    content = await queryCollection('content',).path(`/en/tech${slug.value}`,).first()
  }



  return content
}, {
  watch: [locale,], // Refetch when locale changes
},)

useSeoMeta({
  title: page.value?.title
})

if (!page.value) {
  throw createError({
    status: 404,
    statusText: `Page not found in either ${locale.value} or en locale. Path: ${slug.value}` // TODO move to dictionaries, in ru dict mention both langs, in en dict only en lang.
  })
}

</script>

<template>
  <ContentRenderer
    v-if="page"
    :value="page"
  />
</template>
