<template>
  <div>
    <div class="mx-auto max-w-7xl pt-4 lg:pt-0">
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

        <TwAlert
          v-if="cart.length"
          type="warning"
          title="N'enlève un livre que si tu es sûr·e."
          class="max-w-2xl mx-auto mt-8"
        >
          <p>
            Attention : si tu retires
            <span>{{ cart.length === 1 ? 'ce livre' : 'tes livres' }}</span> tu ne pourras plus
            le<span>{{ cart.length > 1 ? 's ' : '' }}</span> remettre dans ton panier ! Mais aucune
            inquiétude, tu pourras toujours l'acheter directement en cliquant sur le bouton Acheter
            ci-dessus.
          </p>
        </TwAlert>
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
                <dd class="text-base font-medium text-gray-900">{{ prices + 3 }} €</dd>
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
          <TwAlert v-if="bought" type="success" title="Merci pour ton achat !" class="mt-8">
            <p>Félicitations ! Une nouvelle aventure va rejoindre ton étagère d'ici peu ! 🎉</p>
          </TwAlert>
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
import { useFetchCart } from '@/api/fetchs/useFetchCart'

import { TwAlert } from '@/libs/ui/index.vue'

import type { Books } from '@/libs/interfaces/books'

const { retrieve, del, purchase } = useFetchCart()
const cart = await retrieve()
const bought = ref(false)

const prices = cart
  .map((book) => book.price)
  .reduce((acc, current) => {
    return acc + current
  }, 0)

onMounted(async () =>
  computed(() => {
    try {
      return cart
    } catch (error) {
      throw new Error((error as Error).message)
    }
  })
)

const removeItem = async (id: Books['id']) => await del(id)

const buy = () => {
  try {
    if (!cart) return
    cart.map(async (book) => {
      purchase(book.id)
      bought.value = true
    })
  } catch (error) {
    throw new Error((error as Error).message)
  }
}
</script>
