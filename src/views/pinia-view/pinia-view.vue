<script lang="ts">
import { defineComponent, onMounted, ref, watch } from 'vue';
import { usePeopleStore } from '@/stores/people.store';
import type { IPeople, IPeopleStore } from '@/types/all.interfaces';
import MainCardComponent from '@/components/main-card-component/main-card-component.vue';

export default defineComponent({
  components: { MainCardComponent },
  setup() {
    const peopleStore = usePeopleStore();
    const fetchError = ref(false);
    const peopleToShow = ref<IPeopleStore | null>(null);
    const inputModel = ref('');
    const showModal = ref<IPeople | null>(null);
    onMounted(async () => {
      try {
        const response = await fetch('http://127.0.0.1:3000/');
        if (response.ok) {
          peopleStore.fillPeoples(await response.json());
          peopleToShow.value = peopleStore.peoples;
          fetchError.value = false;
        } else {
          fetchError.value = true;
        }
      } catch (error) {
        console.error(error);
        fetchError.value = true;
      }
    });

    watch(
      () => inputModel,
      () => {
        filterPeople();
      },
      { deep: true },
    );

    function filterPeople() {
      if (inputModel.value !== '') {
        const filteredPeople: IPeopleStore = {};
        Object.keys(peopleStore.peoples).forEach((key) => {
          if (
            peopleStore.peoples[key].name.toLowerCase().includes(inputModel.value.toLowerCase())
          ) {
            filteredPeople[key] = peopleStore.peoples[key];
          }
        });
        peopleToShow.value = filteredPeople;
      } else {
        peopleToShow.value = peopleStore.peoples;
      }
    }

    function setModal(name: string) {
      if (name) {
        showModal.value = peopleStore.peoples[name];
      } else {
        showModal.value = null;
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
      filterPeople,
      setModal,
      showModal,
      formatDate,
    };
  },
});
</script>

<template src="./pinia-view.html"></template>

<style scoped></style>