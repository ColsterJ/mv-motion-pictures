<script setup>
import { ref, watchEffect } from "vue";
import MotionPictureTable from './components/MotionPictureTable.vue';
import MotionPictureForm from './components/MotionPictureForm.vue';
import { api_getAll, api_post } from './api.js';

const refreshData = ref(true);
const currentList = ref([]);

const activeRecordIndex = ref(null);
const showForm = ref(false);
const formMode = ref('add');

watchEffect(async () => {
  if (refreshData.value === true) {
    await getAllRecords();
  }
})

function openForm(mode, editOrCopyIndex=null) {
  if (mode !== 'add' && mode !== 'edit' && mode !== 'copy') {
    console.log("Couldn't open form; not a valid mode!")
    return;
  }

  formMode.value = mode;
  showForm.value = true;
  activeRecordIndex.value = editOrCopyIndex;
}

async function getAllRecords() {
  currentList.value = await api_getAll();
  refreshData.value = false;
}
async function saveForm(payload, id) {
  console.log(payload);
  if (id) {
    console.log(`id to update is ${id}`)
    // TODO: PUT if updating an existing record
  } else {
    const response_ok = await api_post(payload);
    if (response_ok) {
      console.log("Saved successfully!");
      showForm.value = false;
      refreshData.value = true;
    }
  }
}
function deleteRecord(index) {
  console.log(`delete item at index ${index}!`);
}

</script>

<template>
  <div class="container">
    <h1>Motion Pictures</h1>

    <MotionPictureTable
      :data="currentList"
      :class="{'hidden': showForm}"

      @add="openForm('add')"
      @edit="(index) => openForm('edit', index)"
      @copy="(index) => openForm('copy', index)"
      @delete-record="(index) => deleteRecord(index)"
    />

    <MotionPictureForm
      :class="{'hidden': !showForm}"
      :formMode="formMode"
      :initialFormData="activeRecordIndex !== null ? currentList[activeRecordIndex] : null"
      @close-form="showForm = false"
      @save-form="(payload, id, successCallback) => saveForm(payload, id, successCallback)"
    />
  </div>
</template>

<style scoped>
  .hidden {
    display:  none;
  }
</style>