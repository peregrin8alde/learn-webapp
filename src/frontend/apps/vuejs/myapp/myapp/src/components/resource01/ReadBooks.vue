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

            if (import.meta.env.VITE_MOCK_MODE) {
                this.result['status'] = 200
                this.result['statusText'] = 'dummy response.statusText'

                this.result['json'] = [
                    {
                        id: 'dummy001',
                        title: 'dummy title'
                    },
                    {
                        id: 'dummy002',
                        title: 'dummy title2'
                    },
                ]
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
    <form name="read-books">
        <p>
            Response:
            <output>
                <span v-if="result.status === 200">
                    <table class="table table-bordered">
                        <thead class="table-primary">
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">id</th>
                                <th scope="col">title</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="(item, index) in result.json">
                                <th scope="col">{{ index + 1 }}</th>
                                <td scope="col">{{ item.id }}</td>
                                <td scope="col">{{ item.title }}</td>
                            </tr>
                        </tbody>
                    </table>
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
