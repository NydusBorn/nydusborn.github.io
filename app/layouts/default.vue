<script setup lang="ts">
const mapping = {
  "/en_resume.pdf": "Resume (EN)",
  "/ru_resume.pdf": "Resume (RU)",
};

if (import.meta.dev) {
  mapping["/stories/avatar"] = "Stories/Avatar";
}

const reverseMapping = Object.fromEntries(
  Object.entries(mapping).map(([k, v]) => [v, k]),
);
const pages = computed(() => Object.entries(mapping).map(([k, v]) => v));
const page = ref();

function transportTo() {
  useRouter().push(reverseMapping[page.value]).then(() => {
    window.location.reload();
  });
}
</script>

<template>
  <UHeader>
    <template #left>
      <USelectMenu
        v-model="page"
        :items="pages"
        style="width: 150px"
        placeholder="Printed Resume"
        @change="transportTo"
      />
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
