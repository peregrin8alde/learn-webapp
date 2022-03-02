<script>
// vite で作成されるスクリプトに合わせて行末の ; は省略
export default {
    props: {
        baseUrl: String,
        token: String
    },
    data() {
        return {
            title: '',
            result: ''
        }
    },
    methods: {
        create(event) {
            console.log('baseUrl: ' + this.baseUrl)
            console.log('title: ' + this.title)

            const url = this.baseUrl

            let data = {}
            data['title'] = this.title

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

                // レスポンスヘッダで Access-Control-Expose-Headers に指定しないと Fetch API で Location が見れなかった
                const uri = response.headers.get('Location')
                console.log('uri:', uri)

                this.result = uri
            }).catch(error => {
                console.error('Error:', error)
            })
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
            <output>{{ result }}</output>
        </p>
        <p>
            <button type="button" @click="create">create</button>
        </p>
    </form>
</template>

<style scoped>
</style>
