<script>
import CreateBook from './resource01/CreateBook.vue'
import ReadBooks from './resource01/ReadBooks.vue'
import ReadBook from './resource01/ReadBook.vue'
import UpdateBook from './resource01/UpdateBook.vue'
import DeleteBook from './resource01/DeleteBook.vue'

export default {
    components: {
        CreateBook,
        ReadBooks,
        ReadBook,
        UpdateBook,
        DeleteBook,
    },
    props: {
        baseUrl: String
    },
}
</script>

<template>
    <!-- 動的な値を受け渡す場合は v-bind: か : を付けてパラメタ名（ケバブケース） -->
    <CreateBook :base-url="baseUrl" />
    <ReadBooks :base-url="baseUrl" />
    <ReadBook :base-url="baseUrl" />
    <UpdateBook :base-url="baseUrl" />
    <DeleteBook :base-url="baseUrl" />
</template>

<style>
</style>
