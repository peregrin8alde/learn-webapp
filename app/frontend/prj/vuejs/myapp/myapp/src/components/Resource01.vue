<script setup>
// This starter template is using Vue 3 <script setup> SFCs
// Check out https://v3.vuejs.org/api/sfc-script-setup.html#sfc-script-setup
import CreateBook from './resource01/CreateBook.vue'
import ReadBooks from './resource01/ReadBooks.vue'
import ReadBook from './resource01/ReadBook.vue'
import UpdateBook from './resource01/UpdateBook.vue'
import DeleteBook from './resource01/DeleteBook.vue'
</script>

<template>
    <CreateBook base_url="http://localhost:8000/restapp01/books" />
    <ReadBooks base_url="http://localhost:8000/restapp01/books" />
    <ReadBook base_url="http://localhost:8000/restapp01/books" />
    <UpdateBook base_url="http://localhost:8000/restapp01/books" />
    <DeleteBook base_url="http://localhost:8000/restapp01/books" />
</template>

<style>
</style>
