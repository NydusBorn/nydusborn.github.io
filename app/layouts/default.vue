<script setup lang="ts">

</script>

<template>
  <div>
    <AppHeader/>
    <UContainer>
      <UMain>
        <div style="height: 50px;"/>
        <slot/>
      </UMain>
      <UFooter>
        <template #left>
          {{ $t("Site-Title") }} © 2026
        </template>

        <template #default>
          <UButton
            variant="ghost"
            icon="i-iconoir-github"
            to="https://github.com/nydusborn"
          />
          <UButton
            variant="ghost"
            icon="i-arcticons-hh"
            to="https://hh.ru/resume/afe0495dff0f5ffb6f0039ed1f316559536754"
          />
          <UButton
            variant="ghost"
            icon="i-iconoir-telegram"
            to="https://t.me/nydusborn"
          />
          <UButton
            variant="ghost"
            icon="i-iconoir-mail"
            to="mailto:nydusborn@outlook.com"
          />
        </template>

        <template #right>
          <ULink to="https://github.com/NydusBorn/nydusborn.github.io">{{ $t("Link-Source") }}</ULink>
        </template>
      </UFooter>
    </UContainer>
  </div>
</template>
