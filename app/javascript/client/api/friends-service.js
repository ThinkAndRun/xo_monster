import Vue from 'vue'

export let friendsService = {
    index () {
        return Vue.$http.secured.get('/friends')
            .then((response) => Promise.resolve(response))
            .catch((error) => Promise.reject(error))
    }
}