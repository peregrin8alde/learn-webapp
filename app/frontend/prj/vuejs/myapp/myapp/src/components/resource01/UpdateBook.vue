<script>
export default {
    props: {
        base_url: String
    },
    data() {
        return {
            id: '',
            title: '',
            result: ''
        }
    },
    methods: {
        updateById(event) {
            // メソッド内の `this` は、 Vue インスタンスを参照します
            console.log('base_url: ' + this.base_url)
            console.log('id: ' + this.id)
            console.log('title: ' + this.title)

            let dummy = 204

            const url = this.base_url + '/' + this.id;

            this.result = dummy

            // `event` は、ネイティブ DOM イベントです
            if (event) {
                console.log(event.target.tagName)
            }
        }
    }
}
</script>

<template>
    <p>
        <label>
            id:
            <input v-model="id" placeholder="enter the book id" />
        </label>
    </p>
    <p>
        <label>
            title:
            <input v-model="title" placeholder="enter the book title" />
        </label>
    </p>
    <p>
        Response:
        <output>{{ result }}</output>
    </p>
    <p>
        <button @click="updateById">updateById</button>
    </p>
</template>

<style scoped>
</style>
