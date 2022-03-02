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
        deleteById(event) {
            this.result = {}

            console.log('baseUrl: ' + this.baseUrl)
            console.log('id: ' + this.id)

            const url = this.baseUrl + '/' + this.id

            fetch(url, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer ' + this.token,
                }
            }).then(response => {
                console.log('Success:', response)

                this.result['status'] = response.status
                this.result['statusText'] = response.statusText
            }).catch(error => {
                console.error('Error:', error)

                this.result['error'] = error
            })
        }
    }
}
</script>

<template>
    <form name="delete-book">
        <p>
            <label>
                id:
                <input v-model="id" placeholder="enter the book id" />
            </label>
        </p>
        <p>
            Response:
            <output>
                <span v-if="result.status === 204">
                    <p>status: {{ result.status }}</p>
                </span>
                <span v-else>{{ result }}</span>
            </output>
        </p>
        <p>
            <button type="button" class="btn btn-primary" @click="deleteById">deleteById</button>
        </p>
    </form>
</template>

<style scoped>
</style>
