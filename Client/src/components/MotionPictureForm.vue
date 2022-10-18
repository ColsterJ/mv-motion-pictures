<script setup>
const props = defineProps(['data','formMode'])
// const emits = defineEmits(['add','edit','copy','delete-record'])
</script>

<template>
  <div id="mp-edit-form">
    <h2 v-if="formMode === 'add'">Add a new movie</h2>
    <h2 v-if="formMode === 'edit'">Edit a movie</h2>
    <h2 v-if="formMode === 'copy'">Copy a movie</h2>
    <form>
      <div class="form-group">
        <label for="nameControl">Name</label>
        <input type="text" class="form-control" id="nameControl" placeholder="Enter title of movie">
      </div>

      <div class="form-group">
        <label for="descriptionControl">Description</label>
        <textarea class="form-control" id="descriptionControl" placeholder="Enter a description for the movie" />
      </div>
      
      <div class="form-group">
        <label for="releaseYearControl">Release Year</label>
        <input type="text" class="form-control" id="releaseYearControl" placeholder="Enter release year" />
      </div>
    </form>
  </div>
</template>

<style scoped>
</style>
