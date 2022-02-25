<script>
// vite で作成されるスクリプトに合わせて行末の ; は省略
export default {
    props: {
        baseUrl: String
    },
    data() {
        return {
            id: '',
            result: ''
        }
    },
    methods: {
        deleteById(event) {
            // メソッド内の `this` は、 Vue インスタンスを参照します
            console.log('baseUrl: ' + this.baseUrl)
            console.log('id: ' + this.id)

            const url = this.baseUrl + '/' + this.id

            fetch(url, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json'
                }
            }).then(response => {
                console.log('Success:', response)

                this.result = response.status
            }).catch(error => {
                console.error('Error:', error)
            })
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
        <button @click="deleteById">deleteById</button>
    </p>
</template>

<style scoped>
</style>
