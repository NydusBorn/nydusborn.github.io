<script setup lang="ts">
const route = useRoute()
const open = ref(false)

// Collapse the mobile menu whenever the route changes so it never lingers open.
watch(() => route.fullPath, () => {
  open.value = false
})
</script>

<template>
  <header class="sticky top-0 z-50 flex justify-center px-4 pt-4">
    <!-- Desktop: horizontal pill -->
    <nav
      class="hidden md:flex items-center gap-1 rounded-full border border-default bg-default/75 px-2 py-1.5 shadow-lg backdrop-blur"
      aria-label="Main navigation"
    >
      <UButton
        icon="i-lucide-house"
        color="neutral"
        variant="ghost"
        to="/"
        aria-label="Home"
      />
      <UColorModeButton />
    </nav>

    <!-- Mobile: hamburger pill that extends into a vertical one when tapped -->
    <div class="md:hidden min-w-12 rounded-full border border-default bg-default/75 shadow-lg backdrop-blur">
      <button
        type="button"
        class="flex w-full items-center justify-center p-2.5 text-highlighted"
        :aria-expanded="open"
        aria-label="Toggle navigation menu"
        @click="open = !open"
      >
        <UIcon
          :name="open ? 'i-lucide-x' : 'i-lucide-menu'"
          class="size-5"
        />
      </button>

      <!-- Smooth vertical expand/collapse via the grid-rows technique -->
      <div
        class="grid transition-[grid-template-rows] duration-300 ease-out"
        :class="open ? 'grid-rows-[1fr]' : 'grid-rows-[0fr]'"
      >
        <div class="overflow-hidden">
          <div class="flex flex-col items-center gap-1 px-2 pt-1 pb-2">
            <UButton
              icon="i-lucide-house"
              color="neutral"
              variant="ghost"
              to="/"
              aria-label="Home"
            />
            <UColorModeButton />
          </div>
        </div>
      </div>
    </div>
  </header>
</template>
