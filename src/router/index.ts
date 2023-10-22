import { createRouter, createWebHistory } from 'vue-router';
import piniaView from '@/views/pinia-view/pinia-view.vue';
import fetchView from '@/views/fetch-view/fetch-view.vue';
import homeView from '@/views/home/home-view.vue';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: homeView,
    },
    {
      path: '/pinia',
      name: 'pinia',
      component: piniaView,
    },
    {
      path: '/fetch',
      name: 'fetch',
      component: fetchView,
    },
  ],
});

export default router;
