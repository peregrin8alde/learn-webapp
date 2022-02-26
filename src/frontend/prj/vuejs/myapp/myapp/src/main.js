import { createApp } from 'vue'
import App from './App.vue'

let initOptions = {
    url: 'http://localhost:8080/auth', realm: 'myrealm', clientId: 'kong-consumer', onLoad: 'login-required'
}

let keycloak = Keycloak(initOptions);

keycloak.init({ onLoad: initOptions.onLoad }).then((auth) => {
    if (!auth) {
        window.location.reload();
    } else {
        console.log("Authenticated");

        createApp(App, { keycloak: keycloak }).mount('#app')
    }

    //Token Refresh
    setInterval(() => {
        keycloak.updateToken(70).then((refreshed) => {
            if (refreshed) {
                console.log('Token refreshed' + refreshed);
            } else {
                console.log('Token not refreshed, valid for '
                    + Math.round(keycloak.tokenParsed.exp + keycloak.timeSkew - new Date().getTime() / 1000) + ' seconds');
            }
        }).catch(() => {
            console.log('Failed to refresh token');
        });
    }, 6000)
}).catch(() => {
    console.log("Authenticated Failed");
});
