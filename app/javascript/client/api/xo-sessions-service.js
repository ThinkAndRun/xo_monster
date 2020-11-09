import Vue from 'vue'

export let xoSessionsService = {
    index () {
        return Vue.$http.secured.get('/xo_sessions')
            .then((response) => Promise.resolve(response))
            .catch((error) => Promise.reject(error))
    },
    create (params) {
        return Vue.$http.secured.post('/xo_sessions', params)
            .then((response) => Promise.resolve(response))
            .catch((error) => Promise.reject(error))
    },
    show (slug) {
        return Vue.$http.plain.get('/xo_sessions/' + slug)
            .then((response) => Promise.resolve(response))
            .catch((error) => Promise.reject(error))
    }
}