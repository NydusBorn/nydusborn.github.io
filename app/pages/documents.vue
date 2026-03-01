<script setup lang="ts">

useSeoMeta({
  title: $t("Page-Documents")
})

</script>

<template>
  <div
    style="height: calc(100vh - var(--ui-header-height) - 50px); display: flex; flex-direction: column; justify-content: center; align-items: center; gap: 2rem;">
    <UCard class="bg-muted">
      <template #header>
        {{ $t('Documents-Title') }}
      </template>
      <div style="display: flex; flex-direction: column; gap: 1rem;">
        <UButton variant="ghost" :to="$t('Documents-Doc-SinglePage-Link')">{{ $t('Documents-Doc-SinglePage-Title') }}</UButton>
      </div>
    </UCard>
  </div>
</template>

<style scoped lang="scss">

</style>
