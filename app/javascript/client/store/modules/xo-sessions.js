import * as api from '../../api'

export let xoSessions = {
    namespaced: true,
    state: () => ({
        data: []
    }),
    mutations: {
        save(state, data) {
            state.data = data
        },
    },
    actions: {
        reset({ commit }) {
            commit('save', [])
        },
        update({ commit, dispatch, rootState, state }) {
            return new Promise((resolve, reject) => {
                if (!rootState.signedIn) { return reject('Unauthorized') }
                api.xoSessionsService.index()
                    .then((response) => {
                        commit('save', response.data.xo_sessions)
                        resolve(state.data)
                    })
                    .catch((error) => {
                        dispatch('showResponseError', [error, ''], { root: true })
                        reject(error)
                    })
            })
        },
        create({ commit, dispatch, rootState, state }, params) {
            return new Promise((resolve, reject) => {
                if (!rootState.signedIn) { return reject('Unauthorized') }
                api.xoSessionsService.create(params)
                    .then((response) => {
                        resolve(response.data['xo_session'])
                    })
                    .catch((error) => {
                        dispatch('showResponseError', [error, ''], { root: true })
                        reject(error)
                    })
            })
        }
    },
    getters: {

    }
}