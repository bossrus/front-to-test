import { ref } from 'vue';
import { defineStore } from 'pinia';
import type { IPeople, IPeopleStore } from '@/types/all.interfaces';

export const usePeopleStore = defineStore('peopleStore', () => {
  const peoples = ref<IPeopleStore>({});

  function fillPeoples(people: IPeople[]): void {
    peoples.value = {};
    for (const person of people) {
      peoples.value[person.name] = person;
    }
  }

  return {
    peoples,
    fillPeoples,
  };
});
