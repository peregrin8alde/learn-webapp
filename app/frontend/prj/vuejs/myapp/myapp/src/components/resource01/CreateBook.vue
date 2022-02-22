<script>
export default {
    props: {
        base_url: String
    },
    data() {
        return {
            title: '',
            result: ''
        }
    },
    methods: {
        create(event) {
            // メソッド内の `this` は、 Vue インスタンスを参照します
            console.log('base_url: ' + this.base_url)
            console.log('title: ' + this.title)

            let dummy = this.base_url + '/' + "0001"
            
            let data = {}
            data['title'] = this.title

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
            title:
            <input v-model="title" placeholder="enter the book title" />
        </label>
    </p>
    <p>
        Response:
        <output>{{ result }}</output>
    </p>
    <p>
        <button @click="create">create</button>
    </p>
</template>

<style scoped>
</style>
