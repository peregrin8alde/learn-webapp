<script>
import { e } from "../../../dist/assets/vendor.8473d62d"

// vite で作成されるスクリプトに合わせて行末の ; は省略
export default {
    props: {
        baseUrl: String,
        token: String
    },
    data() {
        return {
            title: '',
            result: {}
        }
    },
    methods: {
        create(event) {
            this.result = {}
            // vite 環境変数
            console.log(import.meta.env.VITE_MOCK_MODE)

            console.log('baseUrl: ' + this.baseUrl)
            console.log('title: ' + this.title)

            const url = this.baseUrl

            let data = {}
            data['title'] = this.title

            if (import.meta.env.VITE_MOCK_MODE) {
                this.result['status'] = 201
                this.result['statusText'] = 'dummy response.statusText'

                this.result['url'] = url + '/dummy001'
            } else {
                fetch(url, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'Authorization': 'Bearer ' + this.token,
                    },
                    body: JSON.stringify(data),
                }).then(response => {
                    // POST はリソースを作成してその結果のリソース URI を Location ヘッダで返す
                    console.log('Success:', response)

                    this.result['status'] = response.status
                    this.result['statusText'] = response.statusText

                    // レスポンスヘッダで Access-Control-Expose-Headers に指定しないと Fetch API で Location が見れなかった
                    const uri = response.headers.get('Location')
                    console.log('uri:', uri)

                    this.result['url'] = uri
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
    <form name="create-book">
        <p>
            <label>
                title:
                <input v-model="title" placeholder="enter the book title" />
            </label>
        </p>
        <p>
            Response:
            <output>
                <span v-if="result.status === 201">
                    <p>status: {{ result.status }}</p>
                    <p>url: {{ result.url }}</p>
                </span>
                <span v-else>{{ result }}</span>
            </output>
        </p>
        <p>
            <button type="button" class="btn btn-primary" @click="create">create</button>
        </p>
    </form>
</template>

<style scoped>
</style>
