<template>
  <button
    type="button"
    role="button"
    aria-roledescription="Bouton Aimer ce livre"
    class="flex flex-col items-center"
    @click="like"
  >
    <HeartIcon :class="['h-7 w-7', { 'text-red-600 ': liked }]" />
    <span class="text-xs">J'aime</span>
  </button>
</template>

<script setup lang="ts">
const props = defineProps<{ bookId: string }>()
import { ref } from 'vue'
import { HeartIcon } from '@heroicons/vue/24/solid'
import { useFetchLikes } from '@/api/fetchs/useFetchLikes'
import { useAccountStore } from '@/stores/useAccountStore'

const liked = ref(false)
const like = async () => {
  const accountStore = useAccountStore()
  const likes = (await accountStore.fetchUserData()).likes
  const position = likes?.indexOf(props.bookId)

  if (likes?.includes(props.bookId)) {
    liked.value = true
    const like = likes?.splice(position ?? -1, 1)
    return like
  }

  console.log('likes', likes)
  console.log('like id :', like)
  const { create, del } = useFetchLikes()
  if (liked.value) {
    del(props.bookId)
    liked.value = false
  }
  create(props.bookId)

  liked.value = true
}
</script>
