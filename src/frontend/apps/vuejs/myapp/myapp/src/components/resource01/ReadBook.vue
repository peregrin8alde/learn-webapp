<script>
// vite で作成されるスクリプトに合わせて行末の ; は省略
export default {
    props: {
        baseUrl: String,
        token: String
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
            console.log('baseUrl: ' + this.baseUrl)
            console.log('id: ' + this.id)

            const url = this.baseUrl + '/' + this.id

            fetch(url, {
                method: 'GET',
                headers: {
                    'Authorization': 'Bearer ' + this.token,
                }
            }).then(response => {
                return response.json()
            }).then(json => {
                this.result = json
            }).catch(error => {
                console.error('Error:', error)
            })
        }
    }
}
</script>

<template>
    <form name="read-book">
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
            <button type="button" @click="readById">readById</button>
        </p>
    </form>
</template>

<style scoped>
</style>
