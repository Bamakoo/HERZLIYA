<template>
  <form>
    <div class="space-y-12">
      <slot></slot>
    </div>

    <div class="mt-6 flex items-center justify-end gap-x-6">
      <slot name="actions"></slot>
    </div>
  </form>
</template>

<script setup lang="ts"></script>
