<script setup>
import { ref } from "vue";

const props = defineProps(['data','formMode'])
const emit = defineEmits(['close-form','save-form'])

const name = ref('')
const description = ref('')
const releaseYear = ref(null)

function save() {
  console.log("Save clicked")
  const formData = {
    name: name.value,
    description: description.value,
    releaseYear: releaseYear.value
  }
  emit('save-form', formData);
}

function closeForm() {
  name.value = '';
  description.value = '';
  releaseYear.value = null;
  emit('close-form');
}
</script>

<template>
  <div id="mp-edit-form">
    <h2 v-if="formMode === 'add'">Add a new movie</h2>
    <h2 v-if="formMode === 'edit'">Edit a movie</h2>
    <h2 v-if="formMode === 'copy'">Copy a movie</h2>
    <form>
      <div class="form-group">
        <label for="nameControl">Name</label>
        <input v-model="name" type="text" class="form-control" id="nameControl" placeholder="Enter title of movie">
      </div>

      <div class="form-group">
        <label for="descriptionControl">Description</label>
        <textarea v-model="description" class="form-control" id="descriptionControl" placeholder="Enter a description for the movie" />
      </div>
      
      <div class="form-group">
        <label for="releaseYearControl">Release Year</label>
        <input v-model="releaseYear" type="text" class="form-control" id="releaseYearControl" placeholder="Enter release year" />
      </div>

      <div class="form-group pt-4">
        <button type="button" class="btn btn-primary mr-2" @click="save()">Save</button>
        <button type="button" class="btn btn-secondary" @click="closeForm()">Cancel</button>
      </div>
    </form>
  </div>
</template>

<style scoped>
</style>
