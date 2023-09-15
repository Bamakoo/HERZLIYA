<template>
  <Popover class="ml-4 flow-root text-sm lg:relative lg:ml-8">
    <PopoverButton class="group -m-2 flex items-center p-2">
      <ShoppingBagIcon
        class="h-6 w-6 flex-shrink-0 text-gray-400 group-hover:text-gray-500"
        aria-hidden="true"
      />
      <span class="ml-2 text-sm font-medium text-gray-700 group-hover:text-gray-800">{{
        products.length
      }}</span>
      <span class="sr-only">{{ products.length }} produits dans le panier</span>
    </PopoverButton>
    <transition
      enter-active-class="transition ease-out duration-200"
      enter-from-class="opacity-0"
      enter-to-class="opacity-100"
      leave-active-class="transition ease-in duration-150"
      leave-from-class="opacity-100"
      leave-to-class="opacity-0"
    >
      <PopoverPanel
        class="absolute inset-x-0 top-16 mt-px bg-white pb-6 shadow-lg sm:px-2 lg:left-auto lg:right-0 lg:top-full lg:-mr-1.5 lg:mt-3 lg:w-80 lg:rounded-lg lg:ring-1 lg:ring-black lg:ring-opacity-5"
      >
        <h2 class="sr-only">Panier</h2>

        <form class="mx-auto max-w-2xl px-4">
          <ul role="list" class="divide-y divide-gray-200">
            <li v-for="product in products" :key="product.id" class="flex items-center py-6">
              <img
                :src="product.imageSrc"
                :alt="product.imageAlt"
                class="h-16 w-16 flex-none rounded-md border border-gray-200"
              />
              <div class="ml-4 flex-auto">
                <h3 class="font-medium text-gray-900">
                  <a :href="product.href">{{ product.name }}</a>
                </h3>
                <p class="text-gray-500">{{ product.color }}</p>
              </div>
            </li>
          </ul>

          <button
            type="submit"
            class="w-full rounded-md border border-transparent bg-indigo-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 focus:ring-offset-gray-50"
          >
            Commander
          </button>

          <p class="mt-6 text-center">
            <a href="/cart" class="text-sm font-medium text-indigo-600 hover:text-indigo-500"
              >Voir le panier</a
            >
          </p>
        </form>
      </PopoverPanel>
    </transition>
  </Popover>
</template>

<script setup lang="ts">
import { ShoppingBagIcon } from '@heroicons/vue/24/outline'
import { Popover, PopoverButton, PopoverPanel } from '@headlessui/vue'

const products = [
  {
    id: 1,
    name: 'Throwback Hip Bag',
    href: '#',
    color: 'Salmon',
    imageSrc: 'https://tailwindui.com/img/ecommerce-images/shopping-cart-page-04-product-01.jpg',
    imageAlt:
      'Salmon orange fabric pouch with match zipper, gray zipper pull, and adjustable hip belt.'
  },
  {
    id: 2,
    name: 'Medium Stuff Satchel',
    href: '#',
    color: 'Blue',
    imageSrc: 'https://tailwindui.com/img/ecommerce-images/shopping-cart-page-04-product-02.jpg',
    imageAlt:
      'Front of satchel with blue canvas body, black straps and handle, drawstring top, and front zipper pouch.'
  }
  // More products...
]
</script>
