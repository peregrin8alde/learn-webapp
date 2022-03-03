import { createApp } from 'vue'
import App from './App.vue'
import "bootstrap/dist/css/bootstrap.min.css";

let initOptions = {
    url: 'http://localhost:8080/auth', realm: 'myrealm', clientId: 'kong-consumer', onLoad: 'login-required'
}

if (import.meta.env.VITE_MOCK_MODE) {
    let keycloak = {
        idToken: 'dummy idToken',
        clientId: 'dummy clientId',
        authServerUrl: 'dummy authServerUrl',
        token: 'dummy token',
        idTokenParsed: {
            preferred_username: 'dummy preferred_username',
        },
        authenticated: true,
        logout: function () {
            console.log("dummy logout");
        }
    }

    createApp(App, { keycloak: keycloak }).mount('#app')
} else {
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
}
