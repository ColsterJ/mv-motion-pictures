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

const notificationText = ref(null);
const notificationType = ref(null);

watchEffect(async () => {
  if (refreshData.value === true) {
    await getAllRecords();
  }
});

watchEffect(() => {
  if (showForm.value === true) {
    // Clear the most recent notification when the form is opened
    notificationText.value = null;
    notificationType.value = null;
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
      notificationText.value = `'${payload.name}' has been updated successfully.`;
      notificationType.value = 'success';
      showForm.value = false;
      refreshData.value = true;
    } else {
      notificationText.value = `There was a problem updating '${payload.name}'. Please check your connection and try again.`;
      notificationType.value = 'danger';
    }
  } else {
    const response_ok = await api_post(payload);
    if (response_ok) {
      notificationText.value = `'${payload.name}' has been saved successfully.`;
      notificationType.value = 'success';
      showForm.value = false;
      refreshData.value = true;
    } else {
      notificationText.value = `There was a problem saving '${payload.name}'. Please check your connection and try again.`;
      notificationType.value = 'danger';
    }
  }
}

async function getAllRecords() {
  const responseData = await api_getAll();
  if (responseData === null) {
    notificationText.value = `There was a problem retrieving the list of movies. Please check your connection and try again later.`;
    notificationType.value = 'danger';
  } else {
    motionPictureList.value = responseData;
  }
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
    notificationText.value = `'${record.name}' has been deleted successfully.`;
    notificationType.value = 'success';
    showForm.value = false;
    activeRecordIndex.value = null;
    refreshData.value = true;
  } else {
    notificationText.value = `There was a problem deleting '${record.name}'. Please try again.`;
    notificationType.value = 'danger';
  }
  recordToDelete.value = null;
  showDeleteConfirmation.value = false;
}
</script>

<template>
  <div class="container">
    <h1>Motion Pictures</h1>

    <div
      v-if="notificationText"
      :class="['alert',
        {'alert-danger': notificationType === 'danger'},
        {'alert-success': notificationType === 'success'}]"
      role="alert"
    >
      {{ notificationText }}
    </div>

    <!-- "[{ active: isActive }, errorClass]" -->

    <MotionPictureTable
      :data="motionPictureList"
      :class="{ hidden: showForm }"
      :isLoading="refreshData === true"
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
