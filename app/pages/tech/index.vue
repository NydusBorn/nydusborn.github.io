<script setup lang="ts">
import {useRoute,} from 'vue-router'
import Fuse from 'fuse.js'

useSeoMeta({
  title: $t('Page-Tech',),
},)

const {locale,} = useI18n()

const routeParams = useUrlSearchParams('history', {removeFalsyValues: true,},)

const rp_searchInContent = ref(routeParams['searchInContent'] === 'true',)
watch(rp_searchInContent, (newValue,) => {
  routeParams['searchInContent'] = newValue
})

const rp_searchTerm = ref(routeParams['searchTerm'],)
watch(rp_searchTerm, (newValue,) => {
  routeParams['searchTerm'] = newValue
})

const allData = await queryCollection('content',).all()
const allTags = [...new Set(allData.flatMap(x => x.tags).filter(x => x))].sort()

const techData = allData.filter(x => x.path.startsWith(`/${locale.value}/tech`))

const rp_inclOrMode = ref(routeParams['inclOrMode'])
watch(rp_inclOrMode, (newValue,) => {
  routeParams['inclOrMode'] = newValue
})
const arrayOrString = (paramName: string,) => {
  if (routeParams[paramName]) {
    if (typeof routeParams[paramName] === 'string') {
      return [routeParams[paramName],]
    } else {
      return routeParams[paramName]
    }
  } else {
    return []
  }
}
const rp_selInclTags = ref(arrayOrString('selInclTags'),)
watch(rp_selInclTags, (newValue,) => {
  routeParams['selInclTags'] = newValue
})
const rp_selExclTags = ref(arrayOrString('selExclTags'),)
watch(rp_selExclTags, (newValue,) => {
  routeParams['selExclTags'] = newValue
})

const filtered = computed(() => {
  const posts = techData

  const fuseOptions = {
    keys: ['title', 'tags']
  }
  if (rp_searchInContent.value) {
    fuseOptions.keys.push('description')
  }

  const fuser = new Fuse(posts, fuseOptions)

  let filtered = posts
  if (rp_searchTerm.value) {
    filtered = fuser.search(rp_searchTerm.value).map(x => x.item)
  }

  if (rp_selExclTags.value.length > 0) {
    filtered = filtered.filter(post => !rp_selExclTags.value.some(tag => post.tags.includes(tag)))
  }
  if (rp_selInclTags.value.length > 0) {
    if (rp_inclOrMode.value) {
      filtered = filtered.filter(post => rp_selInclTags.value.some(tag => post.tags.includes(tag)))
    } else {
      filtered = filtered.filter(post => rp_selInclTags.value.every(tag => post.tags.includes(tag)))
    }
  }

  const fposts = []
  for (const post of filtered) {
    fposts.push({
      title: post.title,
      image: post.image ? post.image : null, // TODO find a good placeholder image (or make one)
      to: post.path.replace(`/${locale.value}/tech`, `/tech`),
    })
  }
  return fposts
})

</script>

<template>
  <div>
    <UCard
      style="position: fixed; left: 4rem; top: 10rem; width: 20rem;"
      class="bg-muted"
    >
      <!--      TODO get all of this in shape-->
      <UInput placeholder="Search" v-model="rp_searchTerm"/>
      <br>
      Included tags
      <UFieldGroup>
        <UButton :color="!rp_inclOrMode ? 'primary' : 'neutral'" variant="subtle" label="AND"
                 @click="rp_inclOrMode = false"/>
        <UButton :color="rp_inclOrMode ? 'primary' : 'neutral'" variant="subtle" label="OR"
                 @click="rp_inclOrMode = true"/>
      </UFieldGroup>
      <UInputMenu :items="allTags" multiple v-model="rp_selInclTags"/>
      <br>
      Excluded tags
      <UInputMenu :items="allTags" multiple v-model="rp_selExclTags"/>
      <br>
      Search in content
      <UCheckbox v-model="rp_searchInContent"/>
    </UCard>
    <UBlogPosts :posts="filtered"/>
  </div>
</template>
