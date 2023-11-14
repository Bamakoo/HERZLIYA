<template>
  <div>
    <div class="mx-auto max-w-5xl">
      <h1 class="text-3xl font-bold tracking-tight text-gray-900 text-center">
        {{
          cart.length
            ? `Vous avez ${cart.length} article${cart.length > 1 ? 's' : ''} dans votre panier`
            : 'Votre panier est vide'
        }}
      </h1>

      <form class="mt-12 px-6" @submit.prevent="buy">
        <div class="max-w-sm lg:max-w-lg mx-auto">
          <h2 class="sr-only">Les livres dans votre panier</h2>

          <ul role="list" class="space-y-4">
            <div
              v-for="(book, index) in cart"
              :key="index"
              class="flex flex-1 flex-col justify-between sm:ml-0"
            >
              <div>
                <div class="grid grid-cols-2">
                  <div class="pr-6">
                    <span class="font-semibold font-courrier text-lg block">
                      <RouterLink
                        :to="`books/${book.id}`"
                        rel="noopener nofollow"
                        class="text-gray-700 hover:text-gray-800 hover:underline"
                        >{{ book.title }}</RouterLink
                      >
                    </span>
                    <span class="mt-1 text-sm text-gray-500 block capitalize">{{
                      book.author
                    }}</span>
                  </div>
                  <div>
                    <span class="text-right text-sm font-medium text-gray-900 block"
                      >{{ book.price }} €</span
                    >

                    <button
                      type="button"
                      role="button"
                      aria-roledescription="retirer du panier"
                      class="ml-4 mt-4 text-sm font-medium hover:text-primary-dark underline sm:ml-0 sm:mt-3 inline float-right"
                      @click="removeItem(book.id)"
                    >
                      Enlever
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </ul>
        </div>

        <div
          v-if="cart.length"
          class="bg-red-600/80 border-red-500 text-white p-4 border rounded-md max-w-fit mx-auto mt-8"
        >
          <p>
            Attention : si tu retires
            <span>{{ cart.length === 1 ? ' livre' : 'tes livres' }}</span> tu ne pourras plus
            <span>{{ cart.length === 1 ? "l'" : 'les' }}</span
            >ajouter à nouveau dans ton panier !
          </p>
        </div>
        <div class="mt-10 max-w-sm lg:max-w-lg mx-auto">
          <div class="rounded-lg bg-gray-50 px-4 py-6 sm:p-6 lg:p-8">
            <h2 class="sr-only">Récapitulatif</h2>

            <dl class="-my-4 divide-y divide-gray-200 text-sm">
              <div class="flex items-center justify-between py-4">
                <dt class="text-gray-600">Sous-total</dt>
                <dd class="font-medium text-gray-900">{{ prices ?? 0 }} €</dd>
              </div>
              <div class="flex items-center justify-between py-4">
                <dt class="text-gray-600">Livraison</dt>
                <dd class="font-medium text-gray-900">3 €</dd>
              </div>
              <div class="flex items-center justify-between py-4">
                <dt class="text-base font-medium text-gray-900">Total de la commande</dt>
                <dd class="text-base font-medium text-gray-900">{{ (prices ?? 0) + 3 }} €</dd>
              </div>
            </dl>
          </div>

          <div class="mt-10">
            <button
              type="submit"
              class="w-full rounded-md border border-transparent bg-secondary px-4 py-3 text-base font-medium text-white shadow-sm hover:bg-secondary-dark focus:outline-none focus:ring-2 focus:ring-secondary-light focus:ring-offset-2 focus:ring-offset-gray-50"
              @click="buy"
            >
              Acheter
            </button>
          </div>

          <div class="mt-6 text-center text-sm text-gray-500">
            <p>
              or
              <RouterLink to="/" class="font-medium text-secondary hover:text-secondary-dark">
                Voir d'autres livres
                <span aria-hidden="true"> &rarr;</span>
              </RouterLink>
            </p>
          </div>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import { useAccountStore } from '@/stores/useAccountStore'
import { useFetchCart } from '@/api/fetchs/useFetchCart'
import type { Cart } from '@/libs/interfaces/carts'

import type { Books } from '@/libs/interfaces/books'
import httpClient from '@/api/httpClient'

const accountStore = useAccountStore()
const { retrieve, del } = useFetchCart()
const cart = await retrieve(accountStore.token)

console.log('cart :', cart)
const prices = cart
  .map((book) => book.price)
  .reduce((acc, current) => {
    return acc + current
  }, 0)

onMounted(async () =>
  computed(() => {
    try {
      console.log('cart :', cart)
      return cart
    } catch (error) {
      throw new Error((error as Error).message)
    }
  })
)

const removeItem = async (id: Books['id']) => await del(accountStore.token, id)

const buy = () => {
  try {
    if (!cart) return
    cart.map(async (book) => {
      book.id
      const { data } = await httpClient.patch<Cart>(`/books/${book.id}/purchase`, cart)
      return data
    })
  } catch (error) {
    throw new Error((error as Error).message)
  }
}
</script>
