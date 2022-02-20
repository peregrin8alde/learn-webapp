import { createApp,h } from 'vue'
import MyComponent from './component/MyComponent.vue'

const app = createApp({})
// 必要な事前処理を実行

// オブジェクトの登録
app.component('my-component', MyComponent)

app.mount('#my-app')
