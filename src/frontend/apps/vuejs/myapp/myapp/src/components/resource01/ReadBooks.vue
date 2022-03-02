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
            this.result = {}

            console.log('baseUrl: ' + this.baseUrl)

            const url = this.baseUrl

            fetch(url, {
                method: 'GET',
                headers: {
                    'Authorization': 'Bearer ' + this.token,
                }
            }).then(response => {
                console.log('Success:', response)

                this.result['status'] = response.status
                this.result['statusText'] = response.statusText

                return response.json()
            }).then(json => {
                this.result['json'] = json
            }).catch(error => {
                console.error('Error:', error)

                this.result['error'] = error
            })
        }
    }
}
</script>

<template>
    <form name="read-books">
        <p>
            Response:
            <output>
                <span v-if="result.status === 200">
                    <div v-for="item in result.json">{{ item }}</div>
                </span>
                <span v-else>{{ result }}</span>
            </output>
        </p>
        <p>
            <button type="button" class="btn btn-primary" @click="readAll">readAll</button>
        </p>
    </form>
</template>

<style scoped>
</style>
