<script setup>
import { ref, computed } from "vue";

const props = defineProps(["data", "isLoading"]);
const emits = defineEmits(["add", "edit", "copy", "delete-record"]);

const sortColumn = ref('releaseYear')
const sortOrder = ref('desc')
const sortedData = computed(() => {
  const key = sortColumn.value
  let data = props.data
  if (key) {
    const order = sortOrder.value === 'asc' ? 1 : -1;
    data = data.slice().sort((a, b) => {
      a = a[key]
      b = b[key]
      return (a === b ? 0 : a > b ? 1 : -1) * order
    })
    return data;
  }
})

function sortBy(key) {
  sortColumn.value = key;
  if (sortOrder.value === 'asc') {
    sortOrder.value = 'desc';
  } else {
    sortOrder.value = 'asc';
  }
}
</script>

<template>
  <div id="mp-table">
    <div class="p-2 float-right">
      <button type="button" class="btn btn-primary" @click="$emit('add')">
        + Add
      </button>
    </div>
    <table class="table">
      <thead>
        <tr>
          <th scope="col" @click="sortBy('name')">Name</th>
          <th scope="col" @click="sortBy('description')">Description</th>
          <th scope="col" @click="sortBy('releaseYear')">Release Year</th>
          <th style="min-width: 120px" scope="col">Actions</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(item, index) in sortedData">
          <td>{{ item.name }}</td>
          <td>{{ item.description }}</td>
          <td>{{ item.releaseYear }}</td>
          <td>
            <span class="mp-icon-btn" @click="$emit('edit', item.originalIndex)">✏️</span>
            <span class="mp-icon-btn" @click="$emit('copy', item.originalIndex)">📋</span>
            <span class="mp-icon-btn" @click="$emit('delete-record', item.originalIndex)"
              >🗑️</span
            >
          </td>
        </tr>
      </tbody>
    </table>
    <h3 id="no-movies" v-if="data.length === 0 && !isLoading">
      There are currently no movies available.
    </h3>
  </div>
</template>

<style scoped>
.mp-icon-btn {
  cursor: pointer;
  user-select: none;
}
#no-movies {
  text-align:  center;
}
</style>
