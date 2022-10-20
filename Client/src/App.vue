<script setup>
import { ref, watchEffect } from "vue";
import MotionPictureTable from "./components/MotionPictureTable.vue";
import MotionPictureForm from "./components/MotionPictureForm.vue";
import ConfirmDeleteDialog from "./components/ConfirmDeleteDialog.vue";
import { api_getAll, api_post, api_put, api_delete } from "./api.js";

const refreshData = ref(true);
const motionPictureList = ref([]);

const showForm = ref(false);
const formMode = ref("add");
const activeRecordIndex = ref(null);

const showDeleteConfirmation = ref(false);
const recordToDelete = ref(null);

const messageText = ref(null);
const messageType = ref(null);

watchEffect(async () => {
  if (refreshData.value === true) {
    await getAllRecords();
  }
});

watchEffect(() => {
  if (showForm.value === true) {
    // Reset the success and error messages when the form is opened
    messageText.value = null;
    messageType.value = null;
  }
})

function openForm(mode, editOrCopyIndex = null) {
  if (mode !== "add" && mode !== "edit" && mode !== "copy") {
    console.log("Couldn't open form; not a valid mode!");
    return;
  }

  formMode.value = mode;
  showForm.value = true;
  activeRecordIndex.value = editOrCopyIndex;
}

async function saveForm(payload, id) {
  if (id) {
    const response_ok = await api_put({ ...payload, id: id });
    if (response_ok) {
      messageText.value = `'${payload.name}' has been updated successfully.`;
      messageType.value = 'success';
      showForm.value = false;
      refreshData.value = true;
    }
  } else {
    const response_ok = await api_post(payload);
    if (response_ok) {
      messageText.value = `'${payload.name}' has been saved successfully.`;
      messageType.value = 'success';
      showForm.value = false;
      refreshData.value = true;
    }
  }
}

async function getAllRecords() {
  motionPictureList.value = await api_getAll();
  refreshData.value = false;
}

async function tryDeleteRecord(index) {
  let record;
  if (motionPictureList.value[index] === undefined) {
    console.log("Could not find record to delete!");
    return;
  } else {
    record = motionPictureList.value[index];
    recordToDelete.value = record;
    showDeleteConfirmation.value = true;
  }
}
async function actuallyDeleteRecord(record) {
  const response_ok = await api_delete(record.id);
  if (response_ok) {
    messageText.value = `'${record.name}' has been deleted successfully.`;
    messageType.value = 'success';
    showForm.value = false;
    activeRecordIndex.value = null;
    refreshData.value = true;
  } else {
    messageText.value = `There was a problem deleting '${record.name}'. Please try again.`;
    messageType.value = 'danger';
  }
  recordToDelete.value = null;
  showDeleteConfirmation.value = false;
}
</script>

<template>
  <div class="container">
    <h1>Motion Pictures</h1>

    <div
      v-if="messageText"
      :class="['alert',
        {'alert-danger': messageType === 'danger'},
        {'alert-success': messageType === 'success'}]"
      role="alert"
    >
      {{ messageText }}
    </div>

    <!-- "[{ active: isActive }, errorClass]" -->

    <MotionPictureTable
      :data="motionPictureList"
      :class="{ hidden: showForm }"
      @add="openForm('add')"
      @edit="(index) => openForm('edit', index)"
      @copy="(index) => openForm('copy', index)"
      @delete-record="(index) => tryDeleteRecord(index)"
    />

    <ConfirmDeleteDialog
      v-if="showDeleteConfirmation"
      :dialogOpen="showDeleteConfirmation"
      :recordToDelete="recordToDelete"
      @actually-delete-record="(record) => actuallyDeleteRecord(record)"
      @cancel-delete="showDeleteConfirmation = false"
    />

    <MotionPictureForm
      :class="{ hidden: !showForm }"
      :formOpen="showForm"
      :formMode="formMode"
      :initialFormData="
        activeRecordIndex !== null ? motionPictureList[activeRecordIndex] : null
      "
      :idToUpdate="
        formMode === 'edit' && motionPictureList[activeRecordIndex]
          ? motionPictureList[activeRecordIndex].id
          : null
      "
      @close-form="showForm = false"
      @save-form="
        (payload, id, successCallback) => saveForm(payload, id, successCallback)
      "
      @delete-record="tryDeleteRecord(activeRecordIndex)"
    />
  </div>

</template>

<style scoped>
.hidden {
  display: none;
}
</style>
