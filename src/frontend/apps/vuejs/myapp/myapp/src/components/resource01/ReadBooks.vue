<script>
// vite で作成されるスクリプトに合わせて行末の ; は省略
export default {
    props: {
        baseUrl: String,
        token: String
    },
    data() {
        return {
            result: ''
        }
    },
    methods: {
        readAll(event) {
            console.log('baseUrl: ' + this.baseUrl)

            const url = this.baseUrl

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
    <form name="read-books">
        <p>
            Response:
            <output>{{ result }}</output>
        </p>
        <p>
            <button type="button" @click="readAll">readAll</button>
        </p>
    </form>
</template>

<style scoped>
</style>
