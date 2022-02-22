<script>
export default {
    props: {
        base_url: String
    },
    data() {
        return {
            id: '',
            result: ''
        }
    },
    methods: {
        readById(event) {
            // メソッド内の `this` は、 Vue インスタンスを参照します
            console.log('base_url: ' + this.base_url)
            console.log('id: ' + this.id)

            let dummy = {
                id: this.id,
                title: 'aaa'
            }

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
        Response:
        <output>{{ result }}</output>
    </p>
    <p>
        <button @click="readById">readById</button>
    </p>
</template>

<style scoped>
</style>
