import Vue from 'vue'

export let usersService = {
    me () {
        return Vue.$http.secured.get('/users/me')
            .then((response) => Promise.resolve(response))
            .catch((error) => Promise.reject(error))
    }
}