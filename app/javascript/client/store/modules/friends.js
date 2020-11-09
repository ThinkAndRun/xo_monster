import * as api from '../../api'

export let friends = {
    namespaced: true,
    state: () => ({
        data: []
    }),
    mutations: {
        save(state, friends) {
            state.data = friends
        },
    },
    actions: {
        reset({ commit }) {
            commit('save', [])
        },
        update({ commit, dispatch, rootState, state }) {
            return new Promise((resolve, reject) => {
                if (!rootState.signedIn) { return reject('Unauthorized') }
                api.friendsService.index()
                    .then((response) => {
                        commit('save', response.data.friends)
                        resolve(state.data)
                    })
                    .catch((error) => {
                        dispatch('showResponseError', [error, ''], { root: true })
                        reject(error)
                    })
            })
        }
    },
    getters: {
        vsFriends(state) {
            let friends = state.data.map(el => {
                return {
                    name: el.player_name,
                    value: el.id,
                }
            })
            let anybody = { name: 'Anybody', value: null }
            return [anybody].concat(friends)
        }
    }
}