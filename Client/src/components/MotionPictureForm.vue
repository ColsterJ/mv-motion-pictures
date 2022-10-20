<script setup>
import { ref, watchEffect } from "vue";

const props = defineProps(['data','formMode','initialFormData','idToUpdate'])
const emit = defineEmits(['close-form','save-form','delete-record'])

const name = ref('')
const description = ref('')
const releaseYear = ref(null)

const formElement = ref(null)
const attemptedToSubmit = ref(false);
const formErrorList = ref([]);

watchEffect(async () => {
  if (props.initialFormData !== null) {
    name.value = props.initialFormData.name;
    description.value = props.initialFormData.description;
    releaseYear.value = props.initialFormData.releaseYear.toString();
  } else {
    name.value = '';
    description.value = '';
    releaseYear.value = '';
  }
})

function save() {
  attemptedToSubmit.value = true;

  if (!formElement.value.checkValidity()) {
    const errors = [];
    if (name.value === '') {
      errors.push('You must enter a name.');
    }
    if (releaseYear.value === '') {
      errors.push('You must enter a release year.');
    }
    if (releaseYear.value.length !== 4 || (!/[0-9]{4}/.test(releaseYear.value))) {
      errors.push('Release year must consist of 4 numbers (e.g. 1994).');
    }

    formErrorList.value = errors;

    return;
  }

  const formData = {
    name: name.value,
    description: description.value,
    releaseYear: releaseYear.value
  }
  emit('save-form', formData, props.idToUpdate);
}

function closeForm() {
  attemptedToSubmit.value = false;
  formErrorList.value = [];
  emit('close-form');
}

</script>

<template>
  <div id="mp-edit-form">
    <h2 v-if="formMode === 'add'">Add a new movie</h2>
    <h2 v-if="formMode === 'edit'">Edit a movie</h2>
    <h2 v-if="formMode === 'copy'">Copy a movie</h2>

    <form ref="formElement" :class="{'attempted-submit': attemptedToSubmit}">
      <div class="form-group">
        <label for="nameControl">Name *</label>
        <input required maxlength="50" v-model="name" type="text" class="form-control" id="nameControl" placeholder="Enter title of movie">
      </div>

      <div class="form-group">
        <label for="descriptionControl">Description</label>
        <textarea maxlength="500" v-model="description" class="form-control" id="descriptionControl" placeholder="Enter a description for the movie" />
      </div>
      
      <div class="form-group">
        <label for="releaseYearControl">Release Year *</label>
        <input required maxlength="4" pattern="[0-9]{4}" v-model="releaseYear" type="text" class="form-control" id="releaseYearControl" placeholder="Enter release year" />
      </div>

      <div v-if="formErrorList.length > 0" class="alert alert-danger" role="alert">
        <strong>Please address the following errors:</strong>
        <ul v-if="formErrorList.length > 0">
          <li v-for="formError in formErrorList">{{formError}}</li>
        </ul>
      </div>

      <div class="form-group pt-4">
        <button type="button" class="btn btn-primary mr-2" @click="save()">Save</button>
        <button type="button" class="btn btn-secondary" @click="closeForm()">Cancel</button>
        
        <button v-if="formMode === 'edit'" type="button" class="btn btn-danger float-right" @click="$emit('delete-record')">Delete</button>
      </div>
    </form>
  </div>
</template>

<style scoped>
form.attempted-submit > div > input:invalid {
  border: 1px solid red;
}
</style>
