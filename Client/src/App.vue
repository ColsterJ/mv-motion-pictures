<script setup>
import { ref, watchEffect } from "vue";
import MotionPictureTable from './components/MotionPictureTable.vue';
import MotionPictureForm from './components/MotionPictureForm.vue';
import { api_getAll, api_post, api_put, api_delete } from './api.js';

const refreshData = ref(true);
const currentList = ref([]);

const showForm = ref(false);
const formMode = ref('add');
const activeRecordIndex = ref(null);

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

async function saveForm(payload, id) {
  if (id) {
    const response_ok = await api_put({...payload, id: id});
    if (response_ok) {
      console.log("Updated successfully!");
      showForm.value = false;
      refreshData.value = true;
    }
  } else {
    const response_ok = await api_post(payload);
    if (response_ok) {
      console.log("Saved successfully!");
      showForm.value = false;
      refreshData.value = true;
    }
  }
}

async function getAllRecords() {
  currentList.value = await api_getAll();
  refreshData.value = false;
}

async function deleteRecord(index) {
  let record;
  if (currentList.value[index] === undefined) {
    console.log("Could not find record to delete!")
    return;
  } else {
    record = currentList.value[index];
  }

  const response_ok = await api_delete(record.id);
  if (response_ok) {
    console.log("Deleted successfully!");
    showForm.value = false;
    refreshData.value = true;
  }
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
      :idToUpdate="formMode === 'edit' ? currentList[activeRecordIndex].id : null"
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