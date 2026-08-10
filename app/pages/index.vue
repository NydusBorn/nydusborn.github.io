<script setup lang="ts"></script>

<template>
  <div class="flex h-200 flex-col items-center justify-center gap-6">
    <AvatarShape />

    <p class="text-3xl font-semibold">Mironov Max</p>
    <p class="text-2xl font-semibold">FullStack Developer</p>

    <div class="flex gap-4">
      <UButton
        variant="ghost"
        icon="i-iconoir-github"
        size="xl"
        to="https://github.com/nydusborn"
      />
      <UButton
        variant="ghost"
        icon="i-arcticons-hh"
        size="xl"
        to="https://hh.ru/resume/afe0495dff0f5ffb6f0039ed1f316559536754"
      />
      <UButton
        variant="ghost"
        icon="i-iconoir-telegram"
        size="xl"
        to="https://t.me/nydusborn"
      />
      <UButton
        variant="ghost"
        icon="i-iconoir-mail"
        size="xl"
        to="mailto:nydusborn@outlook.com"
      />
    </div>

      <!-- <ULink>Blog</ULink>
    <ULink>Projects</ULink>   -->
  </div>
</template>
