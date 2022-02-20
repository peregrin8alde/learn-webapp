#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

BASE_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

# npm は Docker コンテナ利用
npm () {
  docker run \
    --rm \
    -v npm_modules:/usr/local/lib/node_modules \
    -v "$(pwd):$(pwd)" \
    -w $(pwd) \
    node \
      npm "$@"
  
  return 0
}

# 初期化
npm init -y

# install
## webpack
npm install webpack webpack-cli --save-dev

## vue
npm install vue@next
npm install -D @vue/compiler-sfc

## vue-loader
npm install -D vue-loader vue-template-compiler

## babel-loader
npm install -D babel-loader @babel/core @babel/preset-env

## vue-style-loader, css-loader
npm install --save-dev vue-style-loader css-loader

# setup
mkdir -p src

tee src/index.js <<'EOF' >> /dev/null
import { createApp,h } from 'vue'
import MyComponent from './component/MyComponent.vue'

const app = createApp({})
// 必要な事前処理を実行

// オブジェクトの登録
app.component('my-component', MyComponent)

app.mount('#my-app')
EOF

mkdir -p src/component
tee src/component/MyComponent.vue <<'EOF' >> /dev/null
<script>
export default {
  data() {
    return {
      greeting: 'Hello World!'
    }
  }
}
</script>

<template>
  <p class="greeting">{{ greeting }}</p>
</template>

<style>
.greeting {
  color: red;
  font-weight: bold;
}
</style>
EOF

mkdir -p dist
tee dist/index.html <<'EOF' >> /dev/null
<!DOCTYPE html>
<html lang="ja">
  <head>
    <meta charset="utf-8" />
    <title>Getting Started</title>
  </head>

  <body>
    <div id="my-app">
      <my-component></my-component>
    </div>

    <script src="main.js"></script>
  </body>
</html>
EOF

tee webpack.config.js <<'EOF' >> /dev/null
const path = require('path');
const { VueLoaderPlugin } = require('vue-loader');

module.exports = {
  entry: './src/index.js',
  output: {
    filename: 'main.js',
    path: path.resolve(__dirname, 'dist'),
  },
  module: {
    rules: [
      {
        test: /\.vue$/,
        loader: 'vue-loader'
      },
      // this will apply to both plain `.js` files
      // AND `<script>` blocks in `.vue` files
      {
        test: /\.js$/,
        loader: 'babel-loader'
      },
      // this will apply to both plain `.css` files
      // AND `<style>` blocks in `.vue` files
      {
        test: /\.css$/,
        use: [
          'vue-style-loader',
          'css-loader'
        ]
      }
    ]
  },
  plugins: [
    new VueLoaderPlugin()
  ],
  resolve: {
    alias: {
      vue$: 'vue/dist/vue.esm-bundler.js'
    }
  }
};
EOF

# etc
# npm コンテナ利用字に package.json などが root 権限で作成されるため、
# 権限変更
sudo chown -R $(id -u):$(id -g) package*

# webpack
sed -i -e 's/"main": "index.js"/"private": true/g' package.json


exit 0
