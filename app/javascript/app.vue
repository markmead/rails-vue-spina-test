<template>
  <div class="max-w-6xl mx-auto px-4 py-8">
    <div class="grid grid-cols-5 gap-12">
      <div class="col-span-1">
        <p>Min Age: {{ min_age }}</p>
        <p>Max Age: {{ max_age }}</p>
        <p>County: {{ county }}</p>
        <div class="mt-5 space-y-4">
          <label
            for="london"
            class="flex flex-col px-3 py-2 bg-gray-50 rounded-md border"
          >
            London
            <input
              type="checkbox"
              value="London"
              id="london"
              class="mt-1 w-5 h-5 form-checkbox"
              v-model="county"
            >
          </label>
          <label
            for="essex"
            class="flex flex-col px-3 py-2 bg-gray-50 rounded-md border"
          >
            Essex
            <input
              type="checkbox"
              value="Essex"
              id="essex"
              class="mt-1 w-5 h-5 form-checkbox"
              v-model="county"
            >
          </label>
          <label
            for="min_age"
            class="flex flex-col px-3 py-2 bg-gray-50 rounded-md border"
          >
            Min Age
            <input
              type="range"
              id="min_age"
              class="mt-1"
              :min="this.min_age_static"
              :max="this.max_age_static"
              v-model="min_age"
            >
          </label>
          <label
            for="max_age"
            class="flex flex-col px-3 py-2 bg-gray-50 rounded-md border"
          >
            Max Age
            <input
              type="range"
              id="max_age"
              class="mt-1"
              :min="this.min_age_static"
              :max="this.max_age_static"
              v-model="max_age"
            >
          </label>
        </div>
      </div>

      <div class="col-span-4">
        <div
          v-if="this.filteredSchools.length !== 0"
          class="grid grid-cols-3 gap-8"
        >
          <app-school
            v-for="school of this.filteredSchools"
            :key="school.id"
            :school="school"
          ></app-school>
        </div>
        <div v-else>
          <p>Sorry, we found no results</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import School from './school'

export default {
  name: 'App',
  data() {
    return {
      schools: '',
      county: [],
      min_age: null,
      max_age: null,
      min_age_static: null,
      max_age_static: null
    }
  },
  props: ['schools_json'],
  components: {
    'app-school': School
  },
  computed: {
    filteredSchools() {
      let schools = this.schools

      if (this.county.length !== 0) {
        schools = schools.filter(school => this.county.includes(school.county))
      }

      schools = schools.filter(school => school.min_age >= this.min_age)
      schools = schools.filter(school => school.max_age <= this.max_age)

      return schools
    }
  },
  mounted() {
    let min_age = 50
    let max_age = 0

    this.schools = JSON.parse(this.schools_json)

    this.schools.forEach(school => {
      min_age = school.min_age < min_age ? school.min_age : min_age
      max_age = school.max_age > max_age ? school.max_age : max_age
    })

    this.min_age = min_age
    this.min_age_static = min_age
    this.max_age = max_age
    this.max_age_static = max_age
  }
}
</script>