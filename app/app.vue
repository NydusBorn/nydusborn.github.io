<script setup lang="ts">
useHead({
  link: [
    {
      rel: "icon",
      href: "/favicon.svg",
      type: "image/svg+xml",
    },
    {
      rel: "icon",
      href: "/favicon.png",
      type: "image/png",
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
