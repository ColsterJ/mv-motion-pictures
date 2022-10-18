<script setup>
import { ref, watchEffect } from "vue";

const refreshData = ref(true);
const API_URL = 'https://localhost:7126/api/MotionPictures';
const currentList = ref([]);

const showForm = ref(false);
const formMode = ref('add');

watchEffect(async () => {
  if (refreshData.value === true) {
    console.log("Trying to get data");
    currentList.value = await (await fetch(API_URL)).json()
    refreshData.value = false;
  }
})

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

</script>

<template>
  <div class="container">
    <h1>Motion Pictures</h1>

    <div id="mp-table" :class="{'hidden': showForm}">
      <div class="p-2 float-right">
        <button type="button" class="btn btn-primary" @click="add()">+ Add</button>
        <button type="button" class="btn btn-primary" @click="refreshData = true">Refresh</button>
      </div>
      <table class="table">
        <thead>
          <tr>
            <th scope="col">Name</th>
            <th scope="col">Description</th>
            <th scope="col">Release Year</th>
            <th style="min-width:  120px" scope="col">Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="item in currentList">
            <td>{{ item.name }}</td>
            <td>{{ item.description }}</td>
            <td>{{ item.releaseYear }}</td>
            <td>
              <span class="mp-icon-btn" @click="edit(item.id)">✏️</span>
              <span class="mp-icon-btn" @click="copy(item.id)">📋</span>
              <span class="mp-icon-btn" @click="deleteRecord(item.id)">🗑️</span>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <div id="mp-edit-form" :class="{'hidden': !showForm}">
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
  </div>
</template>

<style scoped>
  .hidden {
    display:  none;
  }
  .mp-icon-btn {
    cursor: pointer;
    user-select: none;
  }
</style>