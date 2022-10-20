<script setup>
const props = defineProps(["data"]);
const emits = defineEmits(["add", "edit", "copy", "delete-record"]);
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
          <th scope="col">Name</th>
          <th scope="col">Description</th>
          <th scope="col">Release Year</th>
          <th style="min-width: 120px" scope="col">Actions</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(item, index) in data">
          <td>{{ item.name }}</td>
          <td>{{ item.description }}</td>
          <td>{{ item.releaseYear }}</td>
          <td>
            <span class="mp-icon-btn" @click="$emit('edit', index)">✏️</span>
            <span class="mp-icon-btn" @click="$emit('copy', index)">📋</span>
            <span class="mp-icon-btn" @click="$emit('delete-record', index)"
              >🗑️</span
            >
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
