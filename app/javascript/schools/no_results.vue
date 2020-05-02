<template>
  <div class="flex flex-col items-center p-8">
    <h2 class="font-bold leading-7 text-gray-600 text-xxl sm:text-2xl sm:leading-9">
      Sorry, we found no results
    </h2>
    <p class="mt-2 text-sm leading-5 text-gray-500">
      Try adjusting your filters to see more results.
    </p>
    <img :src="NoResultsImage" alt="No results found" class="w-auto mt-4 h-96" />
  </div>
</template>

<script>
import NoResultsImage from 'images/undraw_no_results.svg'

export default {
  data() {
    return {
      NoResultsImage,
    }
  },
}
</script>
