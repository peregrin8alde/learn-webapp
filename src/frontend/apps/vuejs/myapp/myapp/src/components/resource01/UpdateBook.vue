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
            title: '',
            result: ''
        }
    },
    methods: {
        updateById(event) {
            this.result = {}

            console.log('baseUrl: ' + this.baseUrl)
            console.log('id: ' + this.id)
            console.log('title: ' + this.title)

            const url = this.baseUrl + '/' + this.id

            let data = {}
            data['id'] = this.id
            data['title'] = this.title

            if (import.meta.env.VITE_MOCK_MODE) {
                this.result['status'] = 204
                this.result['statusText'] = 'dummy response.statusText'
            } else {
                fetch(url, {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json',
                        'Authorization': 'Bearer ' + this.token,
                    },
                    body: JSON.stringify(data),
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
}
</script>

<template>
    <form name="update-book">
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
            <output>
                <span v-if="result.status === 204">
                    <p>status: {{ result.status }}</p>
                </span>
                <span v-else>{{ result }}</span>
            </output>
        </p>
        <p>
            <button type="button" class="btn btn-primary" @click="updateById">updateById</button>
        </p>
    </form>
</template>

<style scoped>
</style>
