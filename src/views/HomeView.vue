<script setup>
import { ref } from 'vue';
import BaseButton from '@/components/BaseButton/BaseButton.vue'

const msg = ref("Hello")
</script>

<template>
  <main>
    <input type="text" v-model="msg">
    <BaseButton type="primary">Hi there</BaseButton>
  </main>
</template>
