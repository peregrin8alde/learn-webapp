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
            // メソッド内の `this` は、 Vue インスタンスを参照します
            console.log('baseUrl: ' + this.baseUrl)
            console.log('id: ' + this.id)
            console.log('title: ' + this.title)

            const url = this.baseUrl + '/' + this.id

            let data = {}
            data['id'] = this.id
            data['title'] = this.title

            fetch(url, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer ' + this.token,
                },
                body: JSON.stringify(data),
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
            <output>{{ result }}</output>
        </p>
        <p>
            <button type="button" @click="updateById">updateById</button>
        </p>
    </form>
</template>

<style scoped>
</style>
