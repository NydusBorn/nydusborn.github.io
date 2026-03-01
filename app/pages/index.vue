<script setup lang="ts">

useSeoMeta({
  title: $t('Page-Home')
})

const {locale,} = useI18n()

const educationTimeline = ref([
  {
    date: '2025 - 2027',
    title: $t('Index-Masters'),
    description: $t('Index-University'),
    icon: 'i-lucide-graduation-cap'
  },
  {
    date: '2021 - 2025',
    title: $t('Index-Bachelors'),
    description: $t('Index-University'),
    icon: 'i-lucide-graduation-cap'
  },
])

const employmentTimeline = ref([
  {
    date: $t('Index-DKC-Date'),
    title: $t('Index-DKC-Title'),
    description: $t('Index-DKC-Description'),
    icon: 'i-lucide-eye',
  },
])

const {data: shortSkills,} = await useAsyncData(`skills-${locale.value}`, async () => {

  let content = await queryCollection('content',).path(`/${locale.value}/skills_short`,).first()

  if (!content && locale.value !== 'en') {
    content = await queryCollection('content',).path(`/en/skills_short`,).first()
  }

  return content
})

</script>

<template>
  <div>
    <div style="height: 100px;"/>

    <UCard class="bg-muted">
      <div class="flex flex-col md:flex-row gap-12 justify-center items-center">
        <AvatarShape/>

        <div class="flex flex-col items-center md:items-start text-center md:text-left">
          <prose-h1>{{ $t('Site-Title') }}</prose-h1>

          <prose-h6>{{ $t('Index-Job-Title') }}</prose-h6>
        </div>
      </div>
    </UCard>

    <div style="height: 100px;"/>

    <prose-p>
      {{ $t('Index-Intro') }}
    </prose-p>

    <div class="flex flex-col md:flex-row justify-between items-center gap-8">
      <UTimeline :default-value="0" reverse :items="educationTimeline"/>
      <UTimeline :default-value="0" reverse :items="employmentTimeline"
                 :ui="{ item: 'flex-row-reverse text-right' }"/>
    </div>

    <ContentRenderer
      v-if="shortSkills"
      :value="shortSkills"
    />
  </div>
</template>

<style scoped lang="scss">

</style>
