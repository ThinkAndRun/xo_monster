import * as api from '../api'
import router from '../router'

export default {
    reset ({ commit, dispatch }) {
        dispatch('friends/reset')
        dispatch('xoSessions/reset')
        dispatch('game/reset')
        dispatch('closeAllDialogs')
        this.$cable.connection.disconnect()
        this.$cable.connection.connect()
    },

    signOut ({ commit, dispatch }) {
        api.authService.signOut()
            .then((response) => {
                commit('unsetCurrentUser')
                dispatch('reset')
                router.replace('/')
            })
            .catch((error) => {
                console.log(error)
                dispatch('showResponseError', [error, 'Cannot sign out'])
            })
    },
    signIn ({ dispatch }, data) {
        api.authService.signIn(data)
            .then((response) => {
                dispatch('authSucceeded', response)
            })
            .catch((error) => {
                dispatch('authFailed', [error, ''])
            })
    },
    signUp ({ dispatch }, data) {
        api.authService.signUp(data)
            .then((response) => {
                dispatch('authSucceeded', response)
            })
            .catch((error) => {
                dispatch('authFailed', [error, ''])
            })
    },
    authFailed ({ commit, dispatch }, [error, customMessage]) {
        dispatch('showResponseError', [error, customMessage])
        commit('unsetCurrentUser')
    },
    authSucceeded ({ commit, dispatch, state }, response) {
        if (!response.data.csrf) {
            dispatch('authFailed', [response, ''])
            return
        }
        api.usersService.me()
            .then((meResponse) => {
                commit('setCurrentUser', { currentUser: meResponse.data, csrf: response.data.csrf, access: response.data.access })
                dispatch('closeAllDialogs')
                router.replace(state.signInTarget)
            })
            .catch((error) => {
                dispatch('authFailed', [error, ''])
            })
    },
    showResponseError ({ commit, dispatch }, [error, customMessage]) {
        let message = (error.response && error.response.data && error.response.data.error_description) ||
                      (error.response && error.response.data && error.response.data.error) ||
                      customMessage
        commit('showError', message)
    },
    checkSignedIn ({ state }) {
        if (state.signedIn) {
            router.replace(state.signInTarget)
        }
    },
    closeAllDialogs ({ commit, state }) {
        Object.keys(state.dialogs).forEach(name => {
            commit('closeDialog', name)
        })
    },
    openDialog ({ commit, dispatch }, name) {
        dispatch('closeAllDialogs').then(() => {
            commit('openDialog', name)
        })
    },
}