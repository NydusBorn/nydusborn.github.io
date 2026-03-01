<script setup lang="ts">
import { computed } from 'vue'
import { avatarDefaults } from '~/components/avatarDefaults'

defineComponent({
  name: 'AvatarShape'
})

interface Props {
  petals?: number
  foregroundColor?: string
  backgroundColor?: string
  rounding?: number
  size?: number | string
  petalThickness?: number
  gearBaseThickness?: number
  petalLength?: number
  eyeWidth?: number
  eyeHeight?: number
  strokeWidth?: number
  spinning?: boolean
  isCircular?: boolean
}

const props = withDefaults(defineProps<Props>(), avatarDefaults)

const viewBoxSize = 200
const center = viewBoxSize / 2
const innerRadius = computed(() => props.eyeWidth / 2 + 10)
const baseRadius = computed(() => innerRadius.value + props.gearBaseThickness)
const outerRadius = computed(() => baseRadius.value + props.petalLength)

const gearPath = computed(() => {
  const numPetals = props.petals
  const angleStep = (Math.PI * 2) / numPetals
  const r = Math.min(props.rounding, (outerRadius.value - baseRadius.value) / 2)

  let path = ''

  for (let i = 0; i < numPetals; i++) {
    const startAngle = i * angleStep

    // Angles for the teeth (petals)
    const toothWidth = props.petalThickness
    const tStart = startAngle + angleStep * (1 - toothWidth) / 2
    const tEnd = startAngle + angleStep * (1 + toothWidth) / 2

    // Outward rounding (at the top of the tooth)
    // We adjust the points to allow for arcs
    // Angular width of the rounding arc at outerRadius
    const outerRoundingAngle = r / outerRadius.value
    const tStartOuter1 = tStart + outerRoundingAngle
    const tEndOuter1 = tEnd - outerRoundingAngle

    // Inward rounding (at the base of the tooth)
    // Angular width of the rounding arc at baseRadius
    const innerRoundingAngle = r / baseRadius.value

    const x_out_start_pre = center + (outerRadius.value - r) * Math.cos(tStart)
    const y_out_start_pre = center + (outerRadius.value - r) * Math.sin(tStart)
    const x_out_start_post = center + outerRadius.value * Math.cos(tStartOuter1)
    const y_out_start_post = center + outerRadius.value * Math.sin(tStartOuter1)

    const x_out_end_pre = center + outerRadius.value * Math.cos(tEndOuter1)
    const y_out_end_pre = center + outerRadius.value * Math.sin(tEndOuter1)
    const x_out_end_post = center + (outerRadius.value - r) * Math.cos(tEnd)
    const y_out_end_post = center + (outerRadius.value - r) * Math.sin(tEnd)

    const x_in_end = center + baseRadius.value * Math.cos(tEnd)
    const y_in_end = center + baseRadius.value * Math.sin(tEnd)

    // Points for inward rounding between teeth
    const nextStartAngle = (i + 1) * angleStep
    const nextTStart = nextStartAngle + angleStep * (1 - toothWidth) / 2

    // Ensure rounding doesn't exceed available space between teeth
    const maxInnerRoundingAngle = (nextTStart - tEnd) / 2
    const actualInnerRoundingAngle = Math.min(innerRoundingAngle, maxInnerRoundingAngle)

    const tNextInnerStart = nextTStart - actualInnerRoundingAngle

    const x_next_in_start_pre = center + baseRadius.value * Math.cos(tNextInnerStart)
    const y_next_in_start_pre = center + baseRadius.value * Math.sin(tNextInnerStart)

    // Base radial offset for the tooth, adjusted by rounding
    // We use baseRadius + rounding, but if actualInnerRoundingAngle is smaller than expected,
    // we should adjust this radial offset to match where the arc starts.
    const radialOffset = baseRadius.value + (r > 0 ? (actualInnerRoundingAngle / (r / baseRadius.value)) * r : 0)

    if (i === 0) {
      // Start at the base of the first tooth
      path += `M ${center + radialOffset * Math.cos(tStart)} ${center + radialOffset * Math.sin(tStart)}`
    }

    // Line up to the start of outer rounding
    path += ` L ${x_out_start_pre} ${y_out_start_pre}`
    // Outer rounding start arc
    path += ` Q ${center + outerRadius.value * Math.cos(tStart)} ${center + outerRadius.value * Math.sin(tStart)} ${x_out_start_post} ${y_out_start_post}`
    // Top of the tooth
    path += ` A ${outerRadius.value} ${outerRadius.value} 0 0 1 ${x_out_end_pre} ${y_out_end_pre}`
    // Outer rounding end arc
    path += ` Q ${center + outerRadius.value * Math.cos(tEnd)} ${center + outerRadius.value * Math.sin(tEnd)} ${x_out_end_post} ${y_out_end_post}`
    // Line down to the base
    path += ` L ${center + radialOffset * Math.cos(tEnd)} ${center + radialOffset * Math.sin(tEnd)}`
    // Inward rounding at the end of the tooth
    path += ` Q ${x_in_end} ${y_in_end} ${center + baseRadius.value * Math.cos(tEnd + actualInnerRoundingAngle)} ${center + baseRadius.value * Math.sin(tEnd + actualInnerRoundingAngle)}`

    // Arc along inner radius to the next tooth
    path += ` A ${baseRadius.value} ${baseRadius.value} 0 0 1 ${x_next_in_start_pre} ${y_next_in_start_pre}`

    // Inward rounding at the start of the next tooth
    path += ` Q ${center + baseRadius.value * Math.cos(nextTStart)} ${center + baseRadius.value * Math.sin(nextTStart)} ${center + radialOffset * Math.cos(nextTStart)} ${center + radialOffset * Math.sin(nextTStart)}`
  }

  path += ' Z'

  // Add a subpath for the hole (inner circle).
  // With fill-rule="evenodd" this will be cut out (transparent).
  const holeR = Math.max(0, innerRadius.value - 5)
  path += ` M ${center + holeR} ${center}`
  path += ` A ${holeR} ${holeR} 0 1 0 ${center - holeR} ${center}`
  path += ` A ${holeR} ${holeR} 0 1 0 ${center + holeR} ${center}`
  path += ' Z'

  return path
})

// Eye shape components
const eyeTopArc = computed(() => {
  const w = props.eyeWidth
  const h = props.eyeHeight
  const x1 = center - w / 2
  const x2 = center + w / 2
  const y = center
  const cpY = center - h
  return `M ${x1},${y} Q ${center},${cpY} ${x2},${y}`
})

const eyeBottomArc = computed(() => {
  const w = props.eyeWidth
  const h = props.eyeHeight
  const x1 = center - w / 2
  const x2 = center + w / 2
  const y = center
  const cpY = center + h
  return `M ${x1},${y} Q ${center},${cpY} ${x2},${y}`
})

const eyePupilDot = computed(() => ({
  cx: center,
  cy: center,
  r: props.eyeHeight * 0.2
}))

const eyePupilCircle = computed(() => ({
  cx: center,
  cy: center,
  r: props.eyeHeight * 0.5 // Fits into the arcs
}))

const svgRef = ref<SVGSVGElement | null>(null)
defineExpose({
  svgRef
})
</script>

<template>
  <div class="custom-shape-container" :style="{ width: typeof size === 'number' ? size + 'px' : size, height: typeof size === 'number' ? size + 'px' : size }">
    <svg ref="svgRef" :viewBox="`0 0 ${viewBoxSize} ${viewBoxSize}`">
      <!-- Background -->
      <circle v-if="isCircular" :cx="center" :cy="center" :r="viewBoxSize / 2" :fill="backgroundColor" />
      <rect v-else width="100%" height="100%" :fill="backgroundColor" />

      <!-- Gear/Petals with a hole -->
      <path
        :d="gearPath"
        :fill="foregroundColor"
        fill-rule="evenodd"
        clip-rule="evenodd"
        :class="{ spinning: spinning }"
      />

      <!-- Eye Arcs (Black) -->
      <path :d="eyeTopArc" fill="none" :stroke="foregroundColor" :stroke-width="strokeWidth" stroke-linecap="round" />
      <path :d="eyeBottomArc" fill="none" :stroke="foregroundColor" :stroke-width="strokeWidth" stroke-linecap="round" />

      <!-- Pupil Circle (Black circle in the middle) -->
      <circle :cx="eyePupilCircle.cx" :cy="eyePupilCircle.cy" :r="eyePupilCircle.r" :fill="'none'" :stroke="foregroundColor" :stroke-width="strokeWidth"/>

      <!-- Pupil Dot (Black dot in the middle) -->
      <circle :cx="eyePupilDot.cx" :cy="eyePupilDot.cy" :r="eyePupilDot.r" :fill="foregroundColor" />
    </svg>
  </div>
</template>

<style scoped>
.custom-shape-container {
  display: inline-block;
}
svg {
  width: 100%;
  height: 100%;
}

.spinning {
  animation: spin 10s linear infinite;
  transform-origin: center;
}

@keyframes spin {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}
</style>
