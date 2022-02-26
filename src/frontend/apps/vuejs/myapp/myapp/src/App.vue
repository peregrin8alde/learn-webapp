<script setup>
// This starter template is using Vue 3 <script setup> SFCs
// Check out https://v3.vuejs.org/api/sfc-script-setup.html#sfc-script-setup
import Resource01 from './components/Resource01.vue'

defineProps({
  keycloak: Object
})
</script>

<template>
  <div id="app">
    <img src="./assets/logo.png" />
    <h1>{{ msg }}</h1>
    <h2>User: {{ keycloak.idTokenParsed.preferred_username }}</h2>
    <div>
      <button class="btn" @click="keycloak.logout()">Logout</button>
    </div>
    <div id="wrapper">
      <div class="jwt-token">
        <h3 style="color: black;">JWT Token</h3>
        {{ keycloak.idToken }}
      </div>
      <div class="jwt-token">
        <h3 style="color: black;">Info</h3>
        <ul>
          <li>clientId: {{ keycloak.clientId }}</li>
          <li>Auth Server Url: {{ keycloak.authServerUrl }}</li>
        </ul>
      </div>
    </div>

    <h2>restapp01</h2>

    <!-- HTML 内ではケバブケース -->
    <Resource01 base-url="http://localhost:8000/restapp01/books" :token="keycloak.token" />
  </div>
</template>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
h1,
h2 {
  font-weight: normal;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: block;
  margin: 0 10px;
  color: #333;
  font-size: 20px;
}
a {
  color: #42b983;
}
#wrapper {
  display: flex;
  margin-top: 100px;
}
.jwt-token {
  width: 50%;
  display: block;
  padding: 20px;
  margin: 10 0 10px;
  font-size: 13px;
  line-height: 1.42857143;
  color: #333;
  word-break: break-all;
  word-wrap: break-word;
  background-color: #f5f5f5;
  border: 1px solid #ccc;
  border-radius: 4px;
  color: #d63aff;
  font-weight: bolder;
}
.btn {
  color: #fff;
  background-color: #0088ce;
  border-color: #00659c;
  padding: 6px 10px;
  font-size: 14px;
  line-height: 1.3333333;
  border-radius: 1px;
}
</style>
