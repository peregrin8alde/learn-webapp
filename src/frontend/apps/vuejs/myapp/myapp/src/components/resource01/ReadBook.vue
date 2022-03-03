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
            this.result = {}

            console.log('baseUrl: ' + this.baseUrl)
            console.log('id: ' + this.id)

            const url = this.baseUrl + '/' + this.id

            if (import.meta.env.VITE_MOCK_MODE) {
                this.result['status'] = 200
                this.result['statusText'] = 'dummy response.statusText'

                this.result['json'] = {
                    id: this.id,
                    title: 'dummy title'
                }
            } else {
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
            <output>
                <span v-if="result.status === 200">{{ result.json }}</span>
                <span v-else>{{ result }}</span>
            </output>
        </p>
        <p>
            <button type="button" class="btn btn-primary" @click="readById">readById</button>
        </p>
    </form>
</template>

<style scoped>
</style>
