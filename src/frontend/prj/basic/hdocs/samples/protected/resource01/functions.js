let base_url = 'http://localhost:8000/restapp01/books';

let keycloak = new Keycloak();

function initKeycloak() {
    keycloak.init({
        onLoad: 'login-required'
    }).then(function (authenticated) {
        console.log(authenticated ? 'authenticated' : 'not authenticated');
    }).catch(function () {
        console.log('failed to initialize');
    });
}

function logout() {
    keycloak.logout();
}

function fetchPost(form) {
    const url = base_url;

    let data = {};
    data['title'] = form.elements.title.value;

    keycloak.updateToken(30).then(function () {
        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + keycloak.token,
            },
            body: JSON.stringify(data),
        }).then(response => {
            // アロー関数で表現したパターン（複数行の文の場合は {} や 復帰値がある場合は return が必要）
            // POST はリソースを作成してその結果のリソース URI を Location ヘッダで返す
            console.log('Success:', response);

            // レスポンスヘッダで Access-Control-Expose-Headers に指定しないと Fetch API で Location が見れなかった
            const uri = response.headers.get('Location');
            console.log('uri:', uri);

            form.elements.result.value = uri;
        }).catch((error) => {
            console.error('Error:', error);
        });
    }).catch(function () {
        alert('Failed to refresh token');
    });
}

function fetchGetAll(form) {
    const url = base_url;

    fetch(url, {
        method: 'GET',
        headers: {
            'Authorization': 'Bearer ' + keycloak.token,
        }
    }).then(function (response) {
        // 通常の関数で表現したパターン
        return response.json();
    }).then(function (json) {
        form.elements.result.value = JSON.stringify(json);
    }).catch(function (err) {
        console.log('Fetch problem: ' + err.message);
    });
}

function fetchGetById(form) {
    const id = form.elements.id.value;
    const url = base_url + '/' + id;

    fetch(url, {
        method: 'GET',
        headers: {
            'Authorization': 'Bearer ' + keycloak.token,
        }
    }).then(response => response.json())
    .then(json => {
        console.log('json:', json);
        form.elements.result.value = JSON.stringify(json);
    }).catch(err => {
        console.log('Fetch problem: ' + err.message);
    });
}

function fetchPutById(form) {
    const id = form.elements.id.value;
    const url = base_url + '/' + id;

    let data = {};
    data['id'] = id;
    data['title'] = form.elements.title.value;

    fetch(url, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' + keycloak.token,
        },
        body: JSON.stringify(data),
    }).then(response => {
        console.log('Success:', response);

        form.elements.result.value = response.status;
    }).catch((error) => {
        console.error('Error:', error);
    });
}

function fetchDeleteById(form) {
    const id = form.elements.id.value;
    const url = base_url + '/' + id;

    fetch(url, {
        method: 'DELETE',
        headers: {
            'Authorization': 'Bearer ' + keycloak.token,
        },
    }).then(response => {
        console.log('Success:', response);

        form.elements.result.value = response.status;
    }).catch((error) => {
        console.error('Error:', error);
    });
}
