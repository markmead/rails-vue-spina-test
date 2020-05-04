<template>
  <div class="flex h-screen overflow-hidden bg-gray-100">
    <app-sidebar>
      <div class="space-y-4">
        <div>
          <span class="relative z-0 inline-flex shadow-sm">
            <button
              @click="show_as_rows = true"
              type="button"
              class="relative inline-flex items-center px-2 py-2 text-sm font-medium leading-5 text-gray-500 transition duration-150 ease-in-out bg-white border border-gray-300 rounded-l-md hover:text-gray-400 focus:z-10 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:bg-gray-100 active:text-gray-500"
            >
              <svg
                fill="currentColor"
                viewBox="0 0 20 20"
                class="w-5 h-5"
              >
                <path
                  d="M3 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z"
                  clip-rule="evenodd"
                  fill-rule="evenodd"
                ></path>
              </svg>
            </button>
            <button
              @click="show_as_rows = false"
              type="button"
              class="relative inline-flex items-center px-2 py-2 -ml-px text-sm font-medium leading-5 text-gray-500 transition duration-150 ease-in-out bg-white border border-gray-300 rounded-r-md hover:text-gray-400 focus:z-10 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:bg-gray-100 active:text-gray-500"
            >
              <svg
                fill="currentColor"
                viewBox="0 0 20 20"
                class="w-5 h-5"
              >
                <path d="M5 3a2 2 0 00-2 2v2a2 2 0 002 2h2a2 2 0 002-2V5a2 2 0 00-2-2H5zM5 11a2 2 0 00-2 2v2a2 2 0 002 2h2a2 2 0 002-2v-2a2 2 0 00-2-2H5zM11 5a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V5zM14 11a1 1 0 011 1v1h1a1 1 0 110 2h-1v1a1 1 0 11-2 0v-1h-1a1 1 0 110-2h1v-1a1 1 0 011-1z"></path>
              </svg>
            </button>
          </span>
        </div>

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
      <div v-if="this.filteredSchools.length !== 0">
        <template v-if="this.show_as_rows">
          <div class="overflow-hidden bg-white shadow sm:rounded-md">
            <ul class="divide-y divide-gray-200">
              <app-school-link-row
                v-for="school of this.filteredSchools"
                :key="school.id"
                :school="school"
              ></app-school-link-row>
            </ul>
          </div>
        </template>
        <template v-else>
          <div class="grid grid-cols-3 gap-8">
            <app-school-link-block
              v-for="school of this.filteredSchools"
              :key="school.id"
              :school="school"
            ></app-school-link-block>
          </div>
        </template>
      </div>
      <app-no-results v-else></app-no-results>
    </app-wrapper>
  </div>
</template>

<script>
import Sidebar from './schools/sidebar'
import Wrapper from './schools/wrapper'
import SchoolLinkRow from './schools/school_link_row'
import SchoolLinkBlock from './schools/school_link_block'
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
      show_as_rows: true,
      filters: {
        county: [],
        age_range: [0, 50]
      }
    }
  },
  props: ['schools_json'],
  components: {
    'app-sidebar': Sidebar,
    'app-wrapper': Wrapper,
    'app-school-link-row': SchoolLinkRow,
    'app-school-link-block': SchoolLinkBlock,
    'app-legend': Legend,
    'app-filter-checkbox': FilterCheckbox,
    'app-no-results': NoResults,
    'vue-slider': VueSlider
  },
  methods: {
    updateCountyFilter(value) {
      const county = this.filters.county

      county.includes(value) ? county.splice(value, 1) : county.push(value)
    }
  },
  computed: {
    filteredSchools() {
      let schools = this.schools

      if (this.filters.county.length !== 0) {
        schools = schools.filter(school =>
          this.filters.county.includes(school.county)
        )
      }

      schools = schools.filter(
        school => school.min_age >= this.filters.age_range[0]
      )
      schools = schools.filter(
        school => school.max_age <= this.filters.age_range[1]
      )

      return schools
    }
  },
  beforeMount() {
    this.schools = JSON.parse(this.schools_json)
  },
  mounted() {
    let min_age = 50
    let max_age = 0

    this.schools.forEach(school => {
      min_age = school.min_age < min_age ? school.min_age : min_age
      max_age = school.max_age > max_age ? school.max_age : max_age
    })

    this.min_age_static = min_age
    this.max_age_static = max_age
    this.filters.age_range = [min_age, max_age]
  }
}
</script>
