<script setup>
import { ref, watchEffect } from "vue";

const props = defineProps(["recordToDelete", "dialogOpen"]);
const emit = defineEmits(["cancel-delete", "actually-delete-record"]);

const dialogElement = ref(null);

watchEffect(async () => {
  if (props.dialogOpen === true && dialogElement.value) {
    dialogElement.value.showModal();
  }
});
</script>

<template>
  <dialog ref="dialogElement">
    <p>'{{ props.recordToDelete.name }}' will be deleted. Is this okay?</p>
    <form method="dialog">
      <button
        type="button"
        class="btn btn-secondary"
        @click="$emit('cancel-delete')"
      >
        Cancel
      </button>

      <button
        type="button"
        class="btn btn-danger float-right"
        @click="$emit('actually-delete-record', recordToDelete)"
      >
        Yes, Delete
      </button>
    </form>
  </dialog>
</template>

<style scoped>
dialog {
  min-width: 350px;
  border: 0;
  border-radius: 5px;
  box-shadow: 0 3px 10px 2px rgba(0, 0, 0, 0.25);
}
dialog::backdrop {
  background: rgba(0, 0, 0, 0.2);
}
dialog > p {
  text-align: center;
}
</style>
