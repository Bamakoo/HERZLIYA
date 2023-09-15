<!-- <template>
  <div class="mx-auto max-w-7xl ">
    {{ cart }}
   <div v-for="(item, index) in cart.books" :key="index" class="grid grid-cols-2">
      <div>
        <div>{{ item.title }}</div>
        <div>{{ item.author }}</div>
      </div>
      <div>
        <div>{{ item.state }}</div>
        <div>{{ item.price }}</div>
      </div>
    </div>
  </div>
</template> -->

<template>
  <div class="bg-white">
    <div class="mx-auto max-w-4xl px-4 py-16 sm:px-6 sm:py-24 lg:px-8">
      <h1 class="text-3xl font-bold tracking-tight text-gray-900 text-center">
        {{
          books.length
            ? `Vous avez ${books.length} articles dans votre Panier`
            : 'Votre panier est vide'
        }}
      </h1>

      <form class="mt-12">
        <div>
          <h2 class="sr-only">Les livres dans votre panier</h2>

          <ul role="list" class="space-y-4 sm:ml-32 sm:pl-6">
            <!-- <TwCard
              :book="book"
              :to="`books/${book.id}`"
              large
              v-for="(book, index) in books"
              :key="index"
            > -->
            <!-- <div class="flex-shrink-0">
                <img
                  :src="book.img"
                  :alt="book.title"
                  class="h-24 w-24 rounded-lg object-cover object-center sm:h-32 sm:w-32"
                />
              </div> -->

            <div
              v-for="(book, index) in books"
              :key="index"
              class="ml-4 flex flex-1 flex-col justify-between sm:ml-0"
            >
              <div>
                <div class="grid grid-cols-2">
                  <div class="pr-6">
                    <span class="font-semibold font-courrier text-lg block">
                      <a :href="`books/${book.id}`" class="text-gray-700 hover:text-gray-800">{{
                        book.title
                      }}</a>
                    </span>
                    <span class="mt-1 text-sm text-gray-500 block lowercase">{{
                      book.author
                    }}</span>
                  </div>
                  <div>
                    <span class="text-right text-sm font-medium text-gray-900 block"
                      >{{ book.price }} €</span
                    >

                    <button
                      type="button"
                      class="ml-4 mt-4 text-sm font-medium hover:text-primary-dark underline sm:ml-0 sm:mt-3 inline float-right"
                      @click="removeItem(index)"
                    >
                      Enlever
                    </button>
                  </div>
                </div>
              </div>

              <!-- <p class="mt-4 flex space-x-2 text-sm text-gray-700">
                  <CheckIcon
                    v-if="book.inStock"
                    class="h-5 w-5 flex-shrink-0 text-green-500"
                    aria-hidden="true"
                  />
                  <XMarkIcon v-else class="h-5 w-5 flex-shrink-0 text-red-500" aria-hidden="true" />
                  <span>{{ book.inStock ? 'Disponible' : 'Plus disponible' }}</span>
                </p>  -->
            </div>
            <!-- </TwCard> -->
          </ul>
        </div>

        <!-- Order summary -->
        <div class="mt-10 sm:ml-32 sm:pl-6">
          <div class="rounded-lg bg-gray-50 px-4 py-6 sm:p-6 lg:p-8">
            <h2 class="sr-only">Récapitulatif</h2>

            <div class="flow-root">
              <dl class="-my-4 divide-y divide-gray-200 text-sm">
                <div class="flex items-center justify-between py-4">
                  <dt class="text-gray-600">Sous-total</dt>
                  <dd class="font-medium text-gray-900">{{ prices }} €</dd>
                </div>
                <div class="flex items-center justify-between py-4">
                  <dt class="text-gray-600">Livraison</dt>
                  <dd class="font-medium text-gray-900">5 €</dd>
                </div>
                <div class="flex items-center justify-between py-4">
                  <dt class="text-base font-medium text-gray-900">Total de la commande</dt>
                  <dd class="text-base font-medium text-gray-900">{{ prices + 5 }} €</dd>
                </div>
              </dl>
            </div>
          </div>
          <div class="mt-10">
            <button
              type="submit"
              class="w-full rounded-md border border-transparent bg-indigo-600 px-4 py-3 text-base font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 focus:ring-offset-gray-50"
              @click="buy"
            >
              Acheter
            </button>
          </div>

          <div class="mt-6 text-center text-sm text-gray-500">
            <p>
              or
              <a href="#" class="font-medium text-indigo-600 hover:text-indigo-500">
                Voir d'autres livres
                <span aria-hidden="true"> &rarr;</span>
              </a>
              <!-- go.backward pour revenir à la page précédente -->
            </p>
          </div>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import { useCartStore } from '@/stores/useCartStore'
import { useAccountStore } from '@/stores/useAccountStore'
import type { Cart } from '@/libs/interfaces/carts'
import { TwCard } from '@/libs/ui/index.vue'
import { CheckIcon, XMarkIcon } from '@heroicons/vue/20/solid'
import router from '@/router'
import type { Books } from '@/libs/interfaces/books'

const accountStore = useAccountStore()
const cartStore = useCartStore()
const userId = (await accountStore.userList)[0].id
const cart = await cartStore.retrieveCart(userId)

const books = ref([
  {
    id: 'bd11dc9c-1e34-4a6d-a485-8d606e351960',
    title: 'Baise-moi',
    author: 'Virginie Despantes',
    price: 7,
    state: 'good'
  },
  {
    id: '8c2d43f0-a5a0-425e-8cb9-543266b9cfc3',
    title: 'Sister Outsider',
    author: 'AUDRE LORDE',
    price: 15,
    state: 'excellent'
  },
  {
    id: '046dc20c-8c5b-46d3-bde4-fc8e7d6521e4',
    title: 'Orlando',
    author: 'VIRGINIA WOOLF',
    price: 12,
    state: 'okay'
  }
]) //cart.books
const prices = computed(() =>
  books.value
    .map((book) => book.price)
    .reduce((acc, current) => {
      return acc + current
    }, 0)
)
onMounted(async () =>
  computed(() => {
    try {
      return books.value
    } catch (error) {
      throw new Error((error as Error).message)
    }
  })
)

const removeItem = (index: number) => {
  const itemToRemove = books.value.splice(index, 1)
  return itemToRemove
}

const buy = (e: SubmitEvent) => {
  e.preventDefault()
  try {
    if (!books.value) return
    const item = JSON.parse(JSON.stringify(books.value)) //retourne bien tableau d'objet et pas proxy
    /**(3) [{…}, {…}, {…}]
0: {id: 'bd11dc9c-1e34-4a6d-a485-8d606e351960', title: 'Baise-moi', author: 'Virginie Despantes', price: 7, state: 'good'}
1: {id: '8c2d43f0-a5a0-425e-8cb9-543266b9cfc3', title: 'Sister Outsider', author: 'AUDRE LORDE', price: 15, state: 'excellent'}
2: {id: '046dc20c-8c5b-46d3-bde4-fc8e7d6521e4', title: 'Orlando', author: 'VIRGINIA WOOLF', price: 12, state: 'okay'}
length: 3 */
    const data = cartStore.createCart(item)
    return data
  } catch (error) {
    throw new Error((error as Error).message)
  }
}
</script>
