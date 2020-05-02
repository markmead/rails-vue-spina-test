<template>
  <div class="border shadow-lg p-6 rounded-md">
    <p>{{ school.title }}</p>
    <p>{{ school.county }}</p>
    <p>{{ school.min_age }} - {{ school.max_age }}</p>
  </div>
</template>

<script>
export default {
  name: 'School',
  props: ['school']
}
</script>