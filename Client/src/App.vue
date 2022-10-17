<script setup>
import { ref, watchEffect } from "vue";

const refreshData = ref(true);
const API_URL = 'https://localhost:7126/api/MotionPictures';

const currentList = ref([]);

watchEffect(async () => {
  if (refreshData.value === true) {
    console.log("Trying to get data");
    currentList.value = await (await fetch(API_URL)).json()
    refreshData.value = false;
  }
})

function edit(id) {
  console.log(`edit id ${id}!`);
}
function copy(id) {
  console.log(`copy id ${id}!`);
}
function deleteRecord(id) {
  console.log(`delete id ${id}!`);
}

</script>

<template>
  <div class="container">
    <h1>Motion Pictures</h1>
    <div class="p-2 float-right">
      <button type="button" class="btn btn-primary">+ Add</button>
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
</template>

<style scoped>
  .mp-icon-btn {
    cursor: pointer;
    user-select: none;
  }
</style>