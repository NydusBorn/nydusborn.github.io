<script setup lang="ts">
import { ref, watch, } from 'vue'
import { usePreferenceStore, } from '~/stores/preferences'
import { useRoute, } from 'vue-router'
import { DevOnly, } from '#components'

const { locales, setLocale, } = useI18n()
const locale = ref(useI18n().locale.value,)
const preferenceStore = usePreferenceStore()

const mapping = {
  '/': $t('Page-Home',),
  // '/tech': $t('Page-Tech',),
  // '/projects': $t('Page-Projects',),
  '/documents': $t('Page-Documents',),
  '/about': $t('Page-About',),
}

if (import.meta.dev) { // TODO temporary
  mapping['/tech'] = $t('Page-Tech',)
  mapping['/projects'] = $t('Page-Projects',)
}

if (import.meta.dev) {
  mapping['/stories/avatar'] = 'Stories/Avatar'
}

const placeholder = asyncComputed(async () => {
  const route = useRoute()
  const possible = await queryCollection('content',).path(`/${locale.value}${route.fullPath}`,).first()
  if (possible) {
    return possible?.title
  }
  else {
    return route.name
  }
},)

const reverseMapping = Object.fromEntries(Object.entries(mapping,).map(([k, v,],) => [v, k,],),)
const pages = computed(() => Object.entries(mapping,).map(([k, v,],) => v,),)
const page = ref(mapping[useRoute().fullPath],)
const pageWatcher = watch(useRoute(), newVal => page.value = mapping[newVal.fullPath], { immediate: true, },)

function transportTo() {
  useRouter().push(reverseMapping[page.value],)
}

async function langSwitch() {
  await setLocale(locale.value,)

  reloadNuxtApp({
    force: true,
  },)
}
</script>

<template>
  <div class="flex flex-col gap-2" style="margin-top: 8px">
    <div class="sm:fixed sm:top-2 mx-auto transform sm:left-2 z-10">
      <ULocaleSelect
        v-model="locale"
        :locales="locales"
        style="width: 150px;"
        @change="langSwitch"
      />
    </div>
    <div class="sm:fixed sm:top-2 mx-auto sm:left-1/2 sm:transform sm:-translate-x-1/2 z-10">
      <USelectMenu
        v-model="page"
        :items="pages"
        style="width: 200px;"
        :placeholder="placeholder"
        @change="transportTo"
      />
    </div>
    <div class="sm:fixed sm:top-2 mx-auto transform sm:right-2 z-10">
      <ColorModeButton/>
    </div>
  </div>
</template>

<style scoped lang="scss">

</style>
