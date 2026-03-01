<script setup lang="ts">
import { AvatarShape } from '#components'
import { avatarDefaults } from '~/components/avatarDefaults'

const avatarProps = ref({ ...avatarDefaults })
const avatarRef = ref<InstanceType<typeof AvatarShape> | null>(null)

const performScreenshot = () => {
  const svgElement = avatarRef.value?.svgRef
  if (!svgElement) return

  const size = typeof avatarProps.value.size === 'number' ? avatarProps.value.size : 200
  const canvas = document.createElement('canvas')
  canvas.width = size
  canvas.height = size
  const ctx = canvas.getContext('2d')
  if (!ctx) return

  const svgData = new XMLSerializer().serializeToString(svgElement)
  const svgWithXmlns = svgData.includes('xmlns="http://www.w3.org/2000/svg"')
    ? svgData
    : svgData.replace('<svg', '<svg xmlns="http://www.w3.org/2000/svg"')
  const svgBlob = new Blob([svgWithXmlns], { type: 'image/svg+xml;charset=utf-8' })
  const url = URL.createObjectURL(svgBlob)

  const img = new Image()
  img.crossOrigin = 'anonymous'
  img.onload = () => {
    ctx.drawImage(img, 0, 0, size, size)
    URL.revokeObjectURL(url)
    const pngUrl = canvas.toDataURL('image/png')
    const downloadLink = document.createElement('a')
    downloadLink.href = pngUrl
    downloadLink.download = `avatar-${Date.now()}.png`
    document.body.appendChild(downloadLink)
    downloadLink.click()
    document.body.removeChild(downloadLink)
  }
  img.src = url
}
</script>

<template>
  <div class="flex flex-col">
    <UCard class="fixed right-10"
           style="margin-top: 1rem; width: 400px">
      <template #header>
        Options
      </template>
      <div style="display: flex; flex-direction: column; gap: 1rem;">
        <div style="display: flex; flex-direction: row; gap: 1rem; align-items: center;">
          <h1>Petals</h1>
          <UInputNumber v-model="avatarProps.petals" :min="1" :max="100"/>
        </div>
        <div style="display: flex; flex-direction: row; gap: 1rem; align-items: center;">
          <h1>Foreground</h1>
          <UInput v-model="avatarProps.foregroundColor"/>
        </div>
        <div style="display: flex; flex-direction: row; gap: 1rem; align-items: center;">
          <h1>Background</h1>
          <UInput v-model="avatarProps.backgroundColor"/>
        </div>
        <div style="display: flex; flex-direction: row; gap: 1rem; align-items: center;">
          <h1>Rounding</h1>
          <UInputNumber v-model="avatarProps.rounding" :min="1" :max="100"/>
        </div>
        <div style="display: flex; flex-direction: row; gap: 1rem; align-items: center;">
          <h1>Size</h1>
          <UInputNumber v-model="avatarProps.size" :min="1" :max="1000"/>
        </div>
        <div style="display: flex; flex-direction: row; gap: 1rem; align-items: center;">
          <h1>Petal Thickness</h1>
          <UInputNumber v-model="avatarProps.petalThickness" :min="0" :max="1"/>
        </div>
        <div style="display: flex; flex-direction: row; gap: 1rem; align-items: center;">
          <h1>Gear Base Thickness</h1>
          <UInputNumber v-model="avatarProps.gearBaseThickness" :min="1" :max="100"/>
        </div>
        <div style="display: flex; flex-direction: row; gap: 1rem; align-items: center;">
          <h1>Petal Length</h1>
          <UInputNumber v-model="avatarProps.petalLength" :min="1" :max="100"/>
        </div>
        <div style="display: flex; flex-direction: row; gap: 1rem; align-items: center;">
          <h1>Eye Width</h1>
          <UInputNumber v-model="avatarProps.eyeWidth" :min="1" :max="100"/>
        </div>
        <div style="display: flex; flex-direction: row; gap: 1rem; align-items: center;">
          <h1>Eye Height</h1>
          <UInputNumber v-model="avatarProps.eyeHeight" :min="1" :max="100"/>
        </div>
        <div style="display: flex; flex-direction: row; gap: 1rem; align-items: center;">
          <h1>Stroke Width</h1>
          <UInputNumber v-model="avatarProps.strokeWidth" :min="1" :max="100"/>
        </div>
        <div style="display: flex; flex-direction: row; gap: 1rem; align-items: center;">
          <h1>Spinning</h1>
          <UCheckbox v-model="avatarProps.spinning"/>
        </div>
        <div style="display: flex; flex-direction: row; gap: 1rem; align-items: center;">
          <h1>Circular</h1>
          <UCheckbox v-model="avatarProps.isCircular"/>
        </div>
        <UButton @click="performScreenshot">
          Screenshot
        </UButton>
      </div>
    </UCard>
    <AvatarShape ref="avatarRef" v-bind="avatarProps"/>
  </div>
</template>

<style scoped lang="scss">

</style>
