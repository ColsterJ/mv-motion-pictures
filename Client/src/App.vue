<script setup>
import { ref, watchEffect } from "vue";
import MotionPictureTable from './components/MotionPictureTable.vue';
import MotionPictureForm from './components/MotionPictureForm.vue';
import { api_getAll, api_post } from './api.js';

const refreshData = ref(true);
const currentList = ref([]);

const showForm = ref(false);
const formMode = ref('add');

watchEffect(async () => {
  if (refreshData.value === true) {
    await getAllRecords();
  }
})

async function getAllRecords() {
  currentList.value = await api_getAll();
  refreshData.value = false;
}

function add() {
  formMode.value = 'add';
  showForm.value = true;
  console.log(`add a movie!`);
}
function edit(id) {
  formMode.value = 'edit';
  console.log(`edit id ${id}!`);
}
function copy(id) {
  formMode.value = 'copy';
  console.log(`copy id ${id}!`);
}
function deleteRecord(id) {
  console.log(`delete id ${id}!`);
}

async function saveForm(payload, id, successCallback) {
  console.log(payload);
  if (id) {
    console.log(`id to update is ${id}`)
    // TODO: PUT if updating an existing record
  } else {
    const response_ok = await api_post(payload);
    if (response_ok) {
      console.log("Saved successfully!");
      successCallback();
      refreshData.value = true;
    }
  }
}

</script>

<template>
  <div class="container">
    <h1>Motion Pictures</h1>

    <MotionPictureTable
      :data="currentList"
      :class="{'hidden': showForm}"

      @add="add()"
      @edit="(id) => edit(id)"
      @copy="(id) => copy(id)"
      @delete-record="(id) => deleteRecord(id)"
    />

    <MotionPictureForm
      :class="{'hidden': !showForm}"
      :formMode="formMode"
      @close-form="showForm = false"
      @save-form="(payload, id, successCallback) => saveForm(payload, id, successCallback)"
    />
    <!-- :initialFormData="formMode === 'edit' || formMode === 'copy' ? currentList[activeRecordId] : null" -->
  </div>
</template>

<style scoped>
  .hidden {
    display:  none;
  }
</style>