<script>
export default {
    props: {
        base_url: String
    },
    data() {
        return {
            result: ''
        }
    },
    methods: {
        readAll(event) {
            // メソッド内の `this` は、 Vue インスタンスを参照します
            console.log('base_url: ' + this.base_url)

            let dummy = [
                {
                    id: '0001',
                    title: 'aaa'
                },
                {
                    id: '0002',
                    title: 'bbb'
                },
            ]

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
        Response:
        <output>{{ result }}</output>
    </p>
    <p>
        <button @click="readAll">readAll</button>
    </p>
</template>

<style scoped>
</style>
