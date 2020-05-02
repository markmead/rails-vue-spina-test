<template>
  <div class="relative flex items-start">
    <div class="absolute flex items-center h-5">
      <input
        type="checkbox"
        :value="label"
        :id="label"
        @change="updateCountyFilter"
        class="w-4 h-4 text-indigo-600 transition duration-150 ease-in-out form-checkbox"
      />
    </div>
    <div class="text-sm leading-5 pl-7">
      <label
        :for="label"
        class="text-sm font-medium text-gray-700"
      >{{ label }}</label>
    </div>
  </div>
</template>

<script>
export default {
  props: ['label'],
  methods: {
    updateCountyFilter(event) {
      this.$emit('updateCountyFilter', event.target.value)
    }
  }
}
</script>