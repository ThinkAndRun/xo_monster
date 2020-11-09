import { initialState } from './index'

export default {
    reset (state) {
        Object.keys(initialState).forEach(key => {
            state[key] = initialState[key]
        })
    },
    setCurrentUser (state, { currentUser, csrf, access }) {
        state.currentUser = currentUser
        state.signedIn = true
        state.csrf = csrf
        state.access = access
    },
    unsetCurrentUser (state) {
        state.currentUser = {}
        state.signedIn = false
        state.csrf = null
        state.access = null
    },
    refresh (state, { csrf, access }) {
        state.signedIn = true
        state.csrf = csrf
        state.access = access
    },
    openDialog: (state, name) => (state.dialogs[name] = true),
    closeDialog: (state, name) => (state.dialogs[name] = false),
    showError: (state, message) => (state.error = message),
}