<script lang="ts" setup>
import { RouterLink, RouterView } from 'vue-router';
</script>

<template>
  <header>
    <nav>
      <RouterLink
        :class="{ active: $route.path === '/' }"
        to="/"
        >Начальный экран
      </RouterLink>
      <RouterLink
        :class="{ active: $route.path === '/pinia' }"
        to="/pinia"
        >Pinia version
      </RouterLink>
      <RouterLink
        :class="{ active: $route.path === '/fetch' }"
        to="/fetch"
        >Fetch version
      </RouterLink>
    </nav>
  </header>

  <RouterView />
</template>

<style scoped></style>