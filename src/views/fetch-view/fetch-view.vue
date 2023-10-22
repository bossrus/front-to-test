<script lang="ts">
import { defineComponent, onMounted, ref } from 'vue';
import type { IPeople, IPeopleStore } from '@/types/all.interfaces';
import MainCardComponent from '@/components/main-card-component/main-card-component.vue';

export default defineComponent({
  components: { MainCardComponent },
  setup() {
    const fetchError = ref(false);
    const peopleToShow = ref<IPeopleStore | undefined>(undefined);
    const inputModel = ref('');
    const showModal = ref<IPeople | undefined>(undefined);

    async function fetchData() {
      let params = '';
      if (inputModel.value !== '') {
        params = `?term=${inputModel.value.toLowerCase()}`;
      }
      try {
        const response = await fetch('http://127.0.0.1:3000/' + params);
        if (response.ok) {
          peopleToShow.value = await response.json();
          fetchError.value = false;
        } else {
          fetchError.value = true;
        }
      } catch (error) {
        console.error(error);
        fetchError.value = true;
      }
    }

    onMounted(async () => {
      await fetchData();
    });

    function setModal(name: string) {
      if (name && peopleToShow.value) {
        showModal.value = Object.values(peopleToShow.value).find((p) => p.name === name);
      } else {
        showModal.value = undefined;
      }
    }

    function formatDate(dateStr: string) {
      const date = new Date(dateStr);
      return date.toLocaleDateString('ru-RU', {
        day: '2-digit',
        month: '2-digit',
        year: 'numeric',
      });
    }

    return {
      fetchError,
      peopleToShow,
      inputModel,
      setModal,
      showModal,
      formatDate,
      filterPeople: fetchData,
    };
  },
});
</script>

<template src="../pinia-view/pinia-view.html"></template>

<style scoped></style>