<script setup lang="ts">
interface MenuItem {
  label: string;
  href?: string;
  push?: string;
}

const items = ref<MenuItem[]>([
  { label: "Resume (EN)", href: "/en_resume.pdf" },
  { label: "Resume (RU)", href: "/ru_resume.pdf" },
]);

if (import.meta.dev) {
  items.value.push({ label: "Stories/Avatar", push: "/stories/avatar" });
}

const selected = ref<MenuItem | null>(null);

function onMenuChange(item: MenuItem | null) {
  selected.value = null
  if (item.href) {
    window.location.href = item.href;
  }
  else {
    useRouter().push(item.push)
  }
}
</script>

<template>
  <UHeader>
    <template #left>
      <USelectMenu
        v-model="selected"
        :items="items"
        style="width: 150px"
        placeholder="Printed Resume"
        @update:modelValue="onMenuChange"
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
