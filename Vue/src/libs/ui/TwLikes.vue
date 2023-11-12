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

const liked = ref(false)
const like = async () => {
  const { create, del } = useFetchLikes()
  if (liked.value) {
    del()
    liked.value = false
  }
  create(props.bookId)

  liked.value = true

  // accountStore.userAccount?.likes?.push({
  //    userID: 'b5ZvjMmJQNbgzcCahIm6uA==',
  //   bookID: book.value?.id,
  //  })
  console.log('book id : ', props.bookId)
  // fetchLikes.del(book.value?.id as string)
  //POST DANS TABLE LIKES (USER -> LIKES) => USER TOKEN + BOOK ID
}
</script>
