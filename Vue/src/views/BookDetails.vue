<template>
  <div v-if="!showLogin" class="max-w-lg lg:max-w-7xl mx-auto px-8">
    <div class="grid lg:grid-cols-2 gap-x-0 gap-y-8 lg:gap-y-0">
      <h1 class="lg:hidden text-5xl font-bold text-center">
        {{ book?.title ?? 'Titre du livre' }}
      </h1>

      <div class="aspect-square max-w-md mx-auto w-full bg-gray-200 rounded-md">
        <img src="" alt="" />
      </div>
      <div class="space-y-8">
        <div class="flex items-center justify-between lg:block">
          <div>
            <h1 class="hidden lg:block text-5xl font-bold">
              {{ book?.title ?? 'Titre du livre' }}
            </h1>
            <h2 class="text-xl font-medium uppercase">{{ book?.author }}</h2>
          </div>
          <div class="text-right lg:text-left">
            <div class="font-medium">Prix : {{ `${book?.price} €` }}</div>
            <div class="font-medium">État : {{ stateFormat(book?.state) }}</div>
          </div>
          <p>{{ book?.description }}</p>
        </div>

        <div class="flex-row-reverse lg:flex-row flex items-center lg:space-x-4">
          <TwButton size="m" @click="buy" class="ml-4 lg:ml-0 lg:w-1/2 space-x-2" type="button"
            ><CreditCardIcon class="w-5 h-5 mr-2 text-white" /><span>Acheter</span></TwButton
          >
          <TwLikes :book-id="id" />
        </div>
        <TwButton
          type="button"
          size="m"
          class="lg:w-1/2 space-x-2"
          color="border border-secondary hover:bg-secondary text-secondary hover:text-white"
          @click="addCart"
          ><ShoppingCartIcon class="w-5 h-5 mr-2" /><span>Ajouter au panier</span></TwButton
        >

        <TwAlert type="warning" title="Attention à l'ajout du livre dans ton panier !">
          <p>
            Si tu retires ce livre de ton panier tu ne pourras plus le remettre dedans ! Mais aucune
            inquiétude, tu pourras toujours l'acheter directement en cliquant sur le bouton Acheter
            ci-dessus.
          </p>
        </TwAlert>

        <TwAlert
          v-if="cartPanelIsOpen"
          type="success"
          title="Ajouté !"
          closable
          @close="cartPanelIsOpen = false"
        >
          <p>
            <span class="italic">{{ book?.title }}</span> a bien été ajouté à ton panier !
          </p>
        </TwAlert>
        <TwAlert
          v-if="buyingPanelIsOpen"
          type="success"
          title="Acheté !"
          closable
          @close="buyingPanelIsOpen = false"
        >
          <p>
            Merci d'avoir acheté <span class="italic">{{ book?.title }}</span> ! Il te sera livré
            d'ici peu !
          </p>
        </TwAlert>
      </div>
    </div>
  </div>
  <!-- <UserComments :book-id="id" /> -->
  <RouterView v-if="!showLogin" />
  <Login v-if="showLogin" />
</template>

<script setup lang="ts">
import { ref, onBeforeMount } from 'vue'
import { useRoute } from 'vue-router'

import { useAccountStore } from '@/stores/useAccountStore'
import { useFetchCart } from '@/api/fetchs/useFetchCart'
import { useFetchBooks } from '@/api/fetchs/useFetchBooks'
import { stateFormat } from '@/libs/composables/stateFormat'

import Login from './Login.vue'
import { TwButton, TwLikes, TwAlert } from '@/libs/ui/index.vue'
import { CreditCardIcon, ShoppingCartIcon } from '@heroicons/vue/24/outline'
import type { Books } from '@/libs/interfaces/books'

const accountStore = useAccountStore()
const { addToCart, purchase } = useFetchCart()
const { retrieve } = useFetchBooks()

const route = useRoute()
const { id } = route.params
const book = ref<Books>()
const cartPanelIsOpen = ref(false)
const buyingPanelIsOpen = ref(false)
const showLogin = ref(false)
onBeforeMount(async () => (book.value = await retrieve(id as string)))

const addCart = async () => {
  try {
    if (!accountStore.token) showLogin.value = true
    await addToCart(id as string)
    cartPanelIsOpen.value = true
  } catch (error) {
    throw new Error((error as Error).message)
  }
}

const buy = async () => {
  try {
    if (!accountStore.token) {
      showLogin.value = true
      return
    }
    await purchase(id as string)
    buyingPanelIsOpen.value = true
  } catch (error) {
    throw new Error((error as Error).message)
  }
}
</script>
