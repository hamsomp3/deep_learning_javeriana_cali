<script setup lang="ts">
import { computed } from 'vue'
import { useNav } from '@slidev/client'

const props = defineProps<{
  to: string
}>()

const { isPresenter } = useNav()

// Raw <Link to="/sesionN"> navigates AWAY from /presenter/*, killing presenter
// mode. Mirror the official TocList fix: prefix with /presenter when needed.
const href = computed(() => (isPresenter.value ? `/presenter${props.to}` : props.to))
</script>

<template>
  <Link :to="href">
    <slot />
  </Link>
</template>
