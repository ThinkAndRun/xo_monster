import Vue from 'vue'

export let authService = {
    signIn (data) {
        return Vue.$http.plain.post('/signin', data)
            .then(response => Promise.resolve(response))
            .catch(error => Promise.reject(error))
    },
    signUp (data) {
        return Vue.$http.plain.post('/signup', data)
            .then(response => Promise.resolve(response))
            .catch(error => Promise.reject(error))
    },
    signOut () {
        return Vue.$http.secured.delete('/signin')
            .then((response) => Promise.resolve(response))
            .catch((error) => Promise.reject(error))
    },
}

