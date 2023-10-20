<template>
  <button
    type="button"
    role="button"
    aria-roledescription="Bouton pour aimer"
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
import httpClient from '@/api/httpClient'
// import type { Likes } from '../interfaces/likes'

const liked = ref(false)
const like = async () => {
  //   if (liked.value) {
  //  //fetchLikes.create(book.value?.id as string)
  //     // ;('b5ZvjMmJQNbgzcCahIm6uA==')
  //     // accountStore.userAccount?.likes?.push({
  //     //   userID: 'b5ZvjMmJQNbgzcCahIm6uA==',
  //     //   bookID: book.value?.id,
  //     //   createdAt: Date.now()
  //     // })
  //   }
  liked.value = !liked.value
  const data = await httpClient.post(
    `/likes/${props.bookId}`,
    { data: null },
    {
      headers: {
        Authorization: `Bearer b5ZvjMmJQNbgzcCahIm6uA==`
      }
    }
  )
  console.log('book id : ', props.bookId)
  // fetchLikes.del(book.value?.id as string)
  return data
  //POST DANS TABLE LIKES (USER -> LIKES) => USER TOKEN + BOOK ID
}
</script>
