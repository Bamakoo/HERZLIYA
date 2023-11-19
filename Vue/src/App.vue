<script setup lang="ts">
import { RouterView, useRoute } from 'vue-router'
import Header from './components/Header.vue'
import { ArrowLeftIcon } from '@heroicons/vue/24/outline'
import { useAccountStore } from '@/stores/useAccountStore'
import Login from './views/Login.vue'
import router from './router'

const accountStore = useAccountStore()

const route = useRoute()
</script>

<template>
  <Header />
  <Suspense>
    <RouterView v-slot="{ Component }">
      <main class="py-28 lg:py-32 mx-auto">
        <button
          role="button"
          aria-roledescription="Retour"
          class="ml-4 sm:px-2.5 sm:py-1.5 sm:text-xs sm:font-medium sm:leading-6 top-10 transition-colors duration-150 whitespace-nowrap flex items-center lg:hover:text-primary"
          @click="router.back()"
        >
          <span class="sr-only">Retour</span>
          <ArrowLeftIcon class="w-5 h-5 inline mr-2" role="navigation" aria-label="Retour" />
          <span class="text-base inline font-medium">Retour</span>
        </button>
        <Login
          v-if="
            !accountStore.token &&
            route.path !== '/' &&
            route.name !== 'book' &&
            route.path !== '/signup'
          "
        />

        <component v-else :is="Component" />
      </main>
    </RouterView>
  </Suspense>
</template>
