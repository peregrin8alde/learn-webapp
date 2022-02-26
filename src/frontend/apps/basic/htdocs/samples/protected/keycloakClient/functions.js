let keycloak = new Keycloak();

function initKeycloak() {
    var loadData = function () {
        document.getElementById('keycloak').value = JSON.stringify(keycloak, null, "\t");

        var url = 'http://mockbin.org/request';

        var req = new XMLHttpRequest();
        req.open('GET', url, true);
        req.setRequestHeader('Accept', 'application/json');
        req.setRequestHeader('Authorization', 'Bearer ' + keycloak.token);

        req.onreadystatechange = function () {
            if (req.readyState == 4) {
                if (req.status == 200) {
                    //alert('Success');
                    document.getElementById('result').value = req.responseText;
                } else if (req.status == 403) {
                    alert('Forbidden');
                }
            }
        }

        req.send();
    };

    keycloak.init({
        onLoad: 'login-required'
    }).then(function (authenticated) {
        alert(authenticated ? 'authenticated' : 'not authenticated');

        keycloak.updateToken(30).then(function () {
            loadData();
        }).catch(function () {
            alert('Failed to refresh token');
        });
    }).catch(function () {
        alert('failed to initialize');
    });
}

function logout() {
    keycloak.logout();
}
