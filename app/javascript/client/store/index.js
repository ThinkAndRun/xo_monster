import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'
import actions from './actions'
import mutations from './mutations'
import * as modules from './modules'

Vue.use(Vuex)

export const initialState = {
    signInTarget: '/play',
    dialogs: {
        'signin': false,
        'signup': false
    },
    error: ''
}

export default new Vuex.Store({
    state: {
        ...initialState,
        currentUser: {},
        signedIn: false,
        csrf: null,
        access: null,
    },
    actions,
    mutations,
    getters: {
        signedIn: state => state.signedIn,
        currentUserName: state => state.currentUser.name || state.currentUser.email,
        currentUserAvatar: state => (state.currentUser.name || state.currentUser.email || '-').charAt(0).toUpperCase(),
    },
    modules,
    plugins: [createPersistedState({key: 'xoMonster'})]
})
