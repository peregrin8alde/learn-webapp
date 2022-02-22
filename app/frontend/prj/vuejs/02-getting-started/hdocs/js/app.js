const Counter = {
    data() {
        return {
            counter: 0
        }
    },
    mounted() {
        setInterval(() => {
            this.counter++
        }, 1000)
    }
}

Vue.createApp(Counter).mount('#counter')

// 要素の属性をバインド
const AttributeBinding = {
    data() {
        return {
            message: 'You loaded this page on ' + new Date().toLocaleString()
        }
    }
}

Vue.createApp(AttributeBinding).mount('#bind-attribute')

// イベントハンドリング
const EventHandling = {
    data() {
        return {
            message: 'Hello Vue.js!'
        }
    },
    methods: {
        reverseMessage() {
            this.message = this.message
                .split('')
                .reverse()
                .join('')
        }
    }
}

Vue.createApp(EventHandling).mount('#event-handling')

// 双方向バインディング
const TwoWayBinding = {
    data() {
        return {
            message: 'Hello Vue!'
        }
    }
}

Vue.createApp(TwoWayBinding).mount('#two-way-binding')

// 条件分岐
const ConditionalRendering = {
    data() {
        return {
            seen: true
        }
    }
}

Vue.createApp(ConditionalRendering).mount('#conditional-rendering')

// ループ
const ListRendering = {
    data() {
        return {
            todos: [
                { text: 'Learn JavaScript' },
                { text: 'Learn Vue' },
                { text: 'Build something awesome' }
            ]
        }
    }
}

Vue.createApp(ListRendering).mount('#list-rendering')

// コンポーネント（プロパティ付き）
const TodoItem = {
    props: ['todo'],
    template: `<li>{{ todo.text }}</li>`
}

const TodoList = {
    data() {
        return {
            groceryList: [
                { id: 0, text: 'Vegetables' },
                { id: 1, text: 'Cheese' },
                { id: 2, text: 'Whatever else humans are supposed to eat' }
            ]
        }
    },
    components: {
        TodoItem
    }
}

const app = Vue.createApp(TodoList)

app.mount('#todo-list-app')
