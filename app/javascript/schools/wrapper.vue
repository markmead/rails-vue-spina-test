<template>
  <div class="flex flex-col flex-1 w-0 overflow-hidden">
    <main
      class="relative z-0 flex-1 pt-2 pb-6 overflow-y-auto focus:outline-none md:py-6"
      tabindex="0"
    >
      <div class="px-4 mx-auto max-w-7xl sm:px-6 md:px-8">
        <h1 class="text-2xl font-semibold text-gray-900">Nurseries</h1>
      </div>
      <div class="px-4 mx-auto max-w-7xl sm:px-6 md:px-8">
        <div class="py-4">
          <slot />
        </div>
      </div>
    </main>
  </div>
</template>