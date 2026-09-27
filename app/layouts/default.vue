<script setup lang="ts">
</script>

<template>
  <UHeader>
    <template #left>
      <UIcon name="i-lucide-house" />
    </template>
    <template #right>
      <UColorModeButton />
    </template>
  </UHeader>
  <UMain>
    <UContainer>
      <slot />
    </UContainer>
  </UMain>
</template>
