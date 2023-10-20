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
  <div class="bg-white py-28 lg:py-32">
    <div class="mx-auto max-w-5xl">
      <h1 class="text-3xl font-bold tracking-tight text-gray-900 text-center">
        {{
          books?.length
            ? `Vous avez ${books.length} article${books.length > 1 ? 's' : ''} dans votre Panier`
            : 'Votre panier est vide'
        }}
      </h1>

      <form class="mt-12 px-6">
        <div class="max-w-sm lg:max-w-lg mx-auto">
          <h2 class="sr-only">Les livres dans votre panier</h2>

          <ul role="list" class="space-y-4">
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
              class="flex flex-1 flex-col justify-between sm:ml-0"
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
                      @click="removeItem(book.id)"
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
                <dd class="font-medium text-gray-900">5 €</dd>
              </div>
              <div class="flex items-center justify-between py-4">
                <dt class="text-base font-medium text-gray-900">Total de la commande</dt>
                <dd class="text-base font-medium text-gray-900">{{ prices ?? 0 + 5 }} €</dd>
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
import { useFetchCart } from '@/api/fetchs/useFetchCart'
// import type { Cart } from '@/libs/interfaces/carts'
// import { TwCard } from '@/libs/ui/index.vue'
// import { CheckIcon, XMarkIcon } from '@heroicons/vue/20/solid'
import type { Books } from '@/libs/interfaces/books'
import httpClient from '@/api/httpClient'
import type { Cart } from '@/libs/interfaces/carts'

const accountStore = useAccountStore()
const cartStore = useCartStore()
const cart = await cartStore.retrieveCart(accountStore ?? 'b5ZvjMmJQNbgzcCahIm6uA==')
const { del } = useFetchCart()

const books = accountStore.userAccount?.cart?.books
const prices = computed(
  () =>
    books
      ?.map((book) => book.price)
      .reduce((acc, current) => {
        return acc + current
      }, 0)
)
onMounted(async () =>
  computed(() => {
    try {
      return books
    } catch (error) {
      throw new Error((error as Error).message)
    }
  })
)

const removeItem = (id: Books['id']) => {
  const itemToRemove = computed(() => del(accountStore.token, id))
  return itemToRemove
}

const buy = async (e: SubmitEvent) => {
  e.preventDefault()
  try {
    if (!books) return
    const item = JSON.parse(JSON.stringify(books))

    const { data } = await httpClient.post<Cart>('/cart', item, {
      headers: {
        Authorization: `Bearer ${accountStore.token ?? 'b5ZvjMmJQNbgzcCahIm6uA=='}`
      }
    })
    return data
  } catch (error) {
    throw new Error((error as Error).message)
  }
}
</script>
