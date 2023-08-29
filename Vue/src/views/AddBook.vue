<template>
  <TwForm
    title="Ajouter un livre"
    description="Saisissez toutes les données demandées pour ajouter un livre. Tous les chmps sont obligatoires"
    submit-text="Vendre mon livre"
  >
    <label for="">
      Titre du livre
      <input type="text" />
    </label>
  </TwForm>
</template>
<script setup lang="ts">
import { TwForm } from '@/libs/ui/index.vue'
</script>
