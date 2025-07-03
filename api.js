const token = "";

const endpoint = "";

const resource = `http://localhost:8001/${endpoint}`;

const headers = {
    "Authorization": `token ${token}`,
    "Content-Type": "application/json"
};

const body = JSON.stringify({

});

const method = "GET";

const options = {
    method,
    headers,
    //    body,
}

const success = jsonBody => {
    console.log(jsonBody);
}

fetch(
    resource,
    options
).then(response =>
    response.json()
).then(success);
