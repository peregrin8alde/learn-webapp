<script>
export default {
    components: {
    },
    props: {
        keycloak: Object
    },
}
</script>

<template>
    <header
        class="d-flex flex-wrap align-items-center justify-content-center justify-content-md-between py-3 mb-4 border-bottom"
    >
        <img width="32" height="32" src="../assets/logo.png" />

        <ul class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0">
            <li>
                <a href="#" class="nav-link px-2 link-secondary">Home</a>
            </li>
            <li>
                <a href="#" class="nav-link px-2 link-dark">Features</a>
            </li>
            <li>
                <a href="#" class="nav-link px-2 link-dark">Pricing</a>
            </li>
            <li>
                <a href="#" class="nav-link px-2 link-dark">FAQs</a>
            </li>
            <li>
                <a href="#" class="nav-link px-2 link-dark">About</a>
            </li>
        </ul>

        <div class="col-md-3 text-end">
            <span v-if="keycloak.authenticated">
                <button
                    type="button"
                    class="btn btn-outline-primary me-2"
                    @click="keycloak.logout()"
                >Logout</button>
                User: {{ keycloak.idTokenParsed.preferred_username }}
            </span>
            <span v-else>
                <button type="button" class="btn btn-outline-primary me-2">Login</button>
            </span>
        </div>
    </header>
</template>

<style>
</style>
