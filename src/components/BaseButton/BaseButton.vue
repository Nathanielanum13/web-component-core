<template>
  <button :class="[props.type || 'primary']">
    <slot />
  </button>
</template>

<script setup lang="ts">
    import { defineProps } from "vue"
    interface Button {
        type: string;
    }
    const props = defineProps<Button>()

</script>

<style scoped>
@import "@/assets/global.css";
button {
  font-weight: bold;
  color: red;
  padding: .5rem 2rem;
  margin-inline: .25rem;
}
</style>
