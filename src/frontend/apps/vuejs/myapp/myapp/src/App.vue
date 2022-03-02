<script setup>
// This starter template is using Vue 3 <script setup> SFCs
// Check out https://v3.vuejs.org/api/sfc-script-setup.html#sfc-script-setup
import Resource01 from './components/Resource01.vue'
import Header from './components/Header.vue'

defineProps({
  keycloak: Object
})
</script>

<template>
  <div id="app">
    <div class="container-fluid">
      <div class="row">
        <Header :keycloak="keycloak"></Header>
      </div>
      <div class="row text-break">
        <div class="col">
          <h3 style="color: black;">JWT Token</h3>
          <p>{{ keycloak.idToken }}</p>
        </div>
        <div class="col">
          <h3 style="color: black;">Info</h3>
          <ul>
            <li>clientId: {{ keycloak.clientId }}</li>
            <li>Auth Server Url: {{ keycloak.authServerUrl }}</li>
          </ul>
        </div>
      </div>

      <div class="row">
        <h2>restapp01</h2>

        <!-- HTML 内ではケバブケース -->
        <Resource01 base-url="http://localhost:8000/restapp01/books" :token="keycloak.token" />
      </div>
    </div>
  </div>
</template>

<style>
</style>
