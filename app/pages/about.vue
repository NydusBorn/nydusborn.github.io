<script setup lang="ts">

useSeoMeta({
  title: $t("Page-About")
})
</script>

<template>
  <div
    style="height: calc(100vh - var(--ui-header-height) - 50px); display: flex; flex-direction: column; justify-content: center; align-items: center; gap: 2rem;">
    <UCard class="bg-muted">
      <prose-p>{{$t('About-Attribution-1')}} <prose-a to="https://portfolio-template.nuxt.dev/">{{$t('About-Attribution-2')}}</prose-a>.</prose-p>
    </UCard>
    <UCard class="bg-muted">
      <template #header>
        {{ $t('About-Usage-1') }}
      </template>
      <div style="display: flex; flex-direction: column; gap: 1rem;">
        <div style="display: flex; flex-direction: row; gap: 1rem; align-items: center;">
          <UIcon name="i-logos-nuxt" size="2rem"/>
          <prose-p>{{$t('About-Usage-2')}}</prose-p>
        </div>
        <div style="display: flex; flex-direction: row; gap: 1rem; align-items: center;">
          <UIcon name="i-logos-pinia" size="3rem"/>
          <prose-p>{{ $t('About-Usage-3')}}</prose-p>
        </div>
        <div style="display: flex; flex-direction: row; gap: 1rem; align-items: center;">
          <UIcon name="i-logos-vueuse" size="2rem"/>
          <prose-p>{{ $t('About-Usage-4')}}</prose-p>
        </div>
      </div>
    </UCard>
    <UCard class="bg-muted">
      {{ $t('About-Cookies') }}
    </UCard>
  </div>
</template>

<style scoped lang="scss">

</style>
