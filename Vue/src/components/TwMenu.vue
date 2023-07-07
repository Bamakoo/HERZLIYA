<template>
  <nav class="text-right lg:hidden">
    <Menu v-slot="{ open }" as="div" class="relative inline-block text-left" role="menu">
      <MenuButton
        class="inline-flex w-full justify-center rounded-full bg-black bg-opacity-20 p-2 items-center font-medium text-white hover:bg-opacity-30 focus:outline-none focus-visible:ring-2 focus-visible:ring-white focus-visible:ring-opacity-75"
      >
        <Bars3BottomRightIcon
          v-if="!open"
          class="w-5 text-violet-200 hover:text-violet-100"
          aria-hidden="true"
        />
        <XMarkIcon v-else class="w-5 text-violet-200 hover:text-violet-100" aria-hidden="true" />
      </MenuButton>

      <transition
        enter-active-class="transition duration-100 ease-out"
        enter-from-class="transform scale-95 opacity-0"
        enter-to-class="transform scale-100 opacity-100"
        leave-active-class="transition duration-75 ease-in"
        leave-from-class="transform scale-100 opacity-100"
        leave-to-class="transform scale-95 opacity-0"
      >
        <MenuItems
          class="absolute right-0 mt-2 w-56 origin-top-right divide-y divide-gray-100 rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none"
        >
          <div class="px-1 py-1">
            <MenuItem v-for="(item, index) in items" :key="index" v-slot="{ active }">
              <component
                :is="getItemComponent(item)"
                :to="item.to ? item.to : null"
                :onClick="
                  item.onClick
                    ? () => {
                        handleItemClick(item, index)
                        !open
                      }
                    : null
                "
                :class="[
                  active ? 'bg-violet-500 text-white' : 'text-gray-900',
                  'group flex w-full items-center rounded-md px-2 py-2 text-sm'
                ]"
              >
                <component
                  v-if="item.icon"
                  :is="item.icon"
                  :active="active"
                  class="mr-2 h-5 w-5 text-violet-400"
                  aria-hidden="true"
                />
                {{ item.title }}
              </component>
            </MenuItem>
          </div>
        </MenuItems>
      </transition>
    </Menu>
  </nav>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { Menu, MenuButton, MenuItems, MenuItem } from '@headlessui/vue'
import { XMarkIcon, Bars3BottomRightIcon } from '@heroicons/vue/24/outline'

type RouterItem = { to: string; title: string; icon?: any }
type ClickItem = {
  onClick: (options: { items: ClickItem; index: number; icon?: any }) => void
  title: string
  icon?: any
}

const props = defineProps<{ items: Array<RouterItem | ClickItem>; btnClass?: string }>()
const actualMenu = ref(window.location.pathname)

const getItemComponent = (item: RouterItem | ClickItem) => {
  const component = item.to ? 'RouterLink' : 'button'
  return component
}

const handleItemClick = (item: ClickItem, index: number) => {
  item.onClick({ items: item, index })
}
</script>
