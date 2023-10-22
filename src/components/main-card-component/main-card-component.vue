<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
  props: {
    name: {
      type: String,
      required: true,
    },
    phone: {
      type: String,
      required: true,
    },
    email: {
      type: String,
      required: true,
    },
  },
  setup(props: any) {
    return {
      propsName: props.name,
      propsPhone: props.phone,
      propsEmail: props.email,
    };
  },
});
</script>

<template src="./main-card-component.html"></template>

<style scoped></style>