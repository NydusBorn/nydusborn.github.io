<script setup lang="ts">
useHead({
  link: [
    {
      rel: "icon",
      href: "/favicon.png",
    },
  ],
});
useSeoMeta({
  titleTemplate: `nydusborn.github.io`,
  ogImage: "/favicon.png",
});
</script>

<template>
  <UApp>
    <NuxtLayout>
      <NuxtPage />
    </NuxtLayout>
  </UApp>
</template>
