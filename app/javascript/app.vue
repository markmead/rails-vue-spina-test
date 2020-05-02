<template>
  <div class="flex h-screen overflow-hidden bg-gray-100">
    <app-sidebar>
      <div class="space-y-4 ">
        <fieldset>
          <app-legend text="Location"></app-legend>
          <div class="flex flex-col mt-2 space-y-2">
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

        <fieldset>
          <app-legend text="Age Range"></app-legend>
          <div class="mt-2">
            <vue-slider
              v-model="filters.age_range"
              :silent="true"
              :contained="true"
              :min="this.min_age_static"
              :max="this.max_age_static"
            ></vue-slider>
          </div>
        </fieldset>
      </div>

      <div class="px-4 pt-4 pb-8 -mx-4 -mb-4 text-sm text-gray-500 border-t border-gray-200 bg-gray-50">
        <p>{{ this.filters.county }}</p>
        <p>{{ this.filters.age_range.min_age }} - {{ this.filters.age_range.max_age }}</p>
      </div>
    </app-sidebar>
    <app-wrapper>
      <div v-if="this.filteredSchools.length !== 0" class="overflow-hidden bg-white shadow sm:rounded-md">
        <ul class="divide-y divide-gray-200">
          <app-school-link v-for="school of this.filteredSchools" :key="school.id" :school="school"></app-school-link>
        </ul>
      </div>
      <app-no-results v-else></app-no-results>
    </app-wrapper>
  </div>
</template>

<script>
import Sidebar from './schools/sidebar'
import Wrapper from './schools/wrapper'
import SchoolLink from './schools/school_link'
import Legend from './schools/legend'
import FilterCheckbox from './schools/filter_checkbox'
import NoResults from './schools/no_results'

import VueSlider from 'vue-slider-component'
import 'vue-slider-component/theme/default.css'

export default {
  name: 'App',
  data() {
    return {
      schools: '',
      min_age_static: null,
      max_age_static: null,
      filters: {
        county: [],
        age_range: [0, 50],
      },
    }
  },
  props: ['schools_json'],
  components: {
    'app-sidebar': Sidebar,
    'app-wrapper': Wrapper,
    'app-school-link': SchoolLink,
    'app-legend': Legend,
    'app-filter-checkbox': FilterCheckbox,
    'app-no-results': NoResults,
    'vue-slider': VueSlider,
  },
  methods: {
    updateCountyFilter(value) {
      const county = this.filters.county

      county.includes(value) ? county.splice(value, 1) : county.push(value)
    },
  },
  computed: {
    filteredSchools() {
      let schools = this.schools

      if (this.filters.county.length !== 0) {
        schools = schools.filter((school) => this.filters.county.includes(school.county))
      }

      schools = schools.filter((school) => school.min_age >= this.filters.age_range[0])
      schools = schools.filter((school) => school.max_age <= this.filters.age_range[1])

      return schools
    },
  },
  beforeMount() {
    this.schools = JSON.parse(this.schools_json)
  },
  mounted() {
    let min_age = 50
    let max_age = 0

    this.schools.forEach((school) => {
      min_age = school.min_age < min_age ? school.min_age : min_age
      max_age = school.max_age > max_age ? school.max_age : max_age
    })

    this.min_age_static = min_age
    this.max_age_static = max_age
    this.filters.age_range = [min_age, max_age]
  },
}
</script>
