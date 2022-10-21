<script setup>
import { ref, computed } from "vue";

const props = defineProps(["data", "isLoading"]);
const emits = defineEmits(["add", "edit", "copy", "delete-record"]);

const sortColumn = ref("releaseYear");
const sortOrder = ref("desc");
const sortedData = computed(() => {
  const key = sortColumn.value;
  let data = props.data;
  if (key) {
    const order = sortOrder.value === "asc" ? 1 : -1;
    data = data.slice().sort((a, b) => {
      a = a[key];
      b = b[key];
      return (a === b ? 0 : a > b ? 1 : -1) * order;
    });
    return data;
  }
});

function sortBy(key) {
  sortColumn.value = key;
  if (sortOrder.value === "asc") {
    sortOrder.value = "desc";
  } else {
    sortOrder.value = "asc";
  }
}
</script>

<template>
  <div id="mp-table">
    <div class="p-2 float-right">
      <button type="button" class="btn btn-primary" @click="$emit('add')">
        <font-awesome-icon icon="fa-solid fa-circle-plus" /> Add
      </button>
    </div>
    <table class="table">
      <thead>
        <tr>
          <th class="clickable" scope="col" @click="sortBy('name')">
            Name
            {{
              sortColumn === "name" && sortOrder === "desc" ? "&#129095;" : ""
            }}
            {{
              sortColumn === "name" && sortOrder === "asc" ? "&#129093;" : ""
            }}
          </th>
          <th class="clickable" scope="col" @click="sortBy('description')">
            Description
            {{
              sortColumn === "description" && sortOrder === "desc"
                ? "&#129095;"
                : ""
            }}
            {{
              sortColumn === "description" && sortOrder === "asc"
                ? "&#129093;"
                : ""
            }}
          </th>
          <th class="clickable" scope="col" @click="sortBy('releaseYear')">
            Release Year
            {{
              sortColumn === "releaseYear" && sortOrder === "desc"
                ? "&#129095;"
                : ""
            }}
            {{
              sortColumn === "releaseYear" && sortOrder === "asc"
                ? "&#129093;"
                : ""
            }}
          </th>
          <th style="min-width: 120px" scope="col">Actions</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(item, index) in sortedData">
          <td>{{ item.name }}</td>
          <td>{{ item.description }}</td>
          <td>{{ item.releaseYear }}</td>
          <td>
            <span class="clickable m-2" @click="$emit('edit', item.originalIndex)">
              <font-awesome-icon icon="fa-solid fa-pen-to-square" />
            </span>
            <span class="clickable m-2" @click="$emit('copy', item.originalIndex)">
              <font-awesome-icon icon="fa-solid fa-copy" />
            </span>
            <span
              class="clickable m-2"
              @click="$emit('delete-record', item.originalIndex)">
              <font-awesome-icon icon="fa-solid fa-trash" />
            </span>
          </td>
        </tr>
      </tbody>
    </table>
    <div id="spinner-container">
      <div v-if="isLoading" class="spinner-border" role="status">
        <span class="sr-only">Loading...</span>
      </div>
    </div>
    <h3 id="no-movies" v-if="data.length === 0 && !isLoading">
      There are currently no movies available.
    </h3>
  </div>
</template>

<style scoped>
.clickable {
  cursor: pointer;
  user-select: none;
}
#no-movies {
  text-align: center;
}
#spinner-container {
  margin-left:  50%;
}
</style>
