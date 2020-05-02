<template>
  <div class="flex h-screen overflow-hidden bg-gray-100">

    <app-sidebar>
      <fieldset>
        <legend class="block text-base font-medium leading-5 text-gray-700">Location</legend>
        <div class="flex flex-col mt-4 space-y-2">
          <app-filter-checkbox
            label="Essex"
            v-model="filters.county"
            @updateCountyFilter="updateCountyFilter"
          ></app-filter-checkbox>
          <app-filter-checkbox
            label="London"
            v-model="filters.county"
            @updateCountyFilter="updateCountyFilter"
          ></app-filter-checkbox>
        </div>
      </fieldset>

      <div class="p-4 -mx-4 -mb-4 text-sm text-gray-500 border-t border-gray-200 bg-gray-50">
        {{ this.filters.county }}
      </div>

    </app-sidebar>
    <app-wrapper>
      <div class="overflow-hidden bg-white shadow sm:rounded-md">
        <ul class="divide-y divide-gray-200">
          <app-school-link
            v-for="school of this.filteredSchools"
            :key="school.id"
            :school="school"
          ></app-school-link>
        </ul>
      </div>
    </app-wrapper>

  </div>
</template>

<script>
import Sidebar from './schools/sidebar'
import Wrapper from './schools/wrapper'
import SchoolLink from './schools/school_link'
import FilterCheckbox from './schools/filter_checkbox'

export default {
  name: 'App',
  data() {
    return {
      schools: '',
      min_age_static: null,
      max_age_static: null,
      filters: {
        county: [],
        min_age: null,
        max_age: null
      }
    }
  },
  props: ['schools_json'],
  components: {
    'app-school-link': SchoolLink,
    'app-sidebar': Sidebar,
    'app-wrapper': Wrapper,
    'app-filter-checkbox': FilterCheckbox
  },
  methods: {
    updateCountyFilter(value) {
      const county = this.filters.county

      county.includes(value) ? county.splice(value, 1) : county.push(value)
    }
  },
  computed: {
    filteredSchools() {
      // const filters = this.filters
      let schools = this.schools

      if (this.filters.county.length !== 0) {
        schools = schools.filter(school =>
          this.filters.county.includes(school.county)
        )
      }

      // schools = schools.filter(school => school.min_age >= this.min_age)
      // schools = schools.filter(school => school.max_age <= this.max_age)

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