import MainPage from './components/pages/main-page'
import NotFoundPage from './components/pages/not-found-page'
import NewGamePage from './components/pages/new-game-page'
import CurrentGamePage from './components/pages/current-game-page'
import PageWrapper from './components/blocks/page-wrapper'

import Vue from 'vue'
import VueRouter from 'vue-router'
import store from './store'

Vue.use(VueRouter)

const routes = [
    { path: '*', component: PageWrapper, props: { wraps: NotFoundPage } },
    { path: '/', component: MainPage },
    {
        path: '/play',
        component: PageWrapper,
        props: { wraps: NewGamePage },
        meta: { requiresAuth: true },
    },
    {
        path: '/game/:slug',
        component: PageWrapper,
        props: { wraps: CurrentGamePage },
        meta: { requiresAuth: true }
    },
    { path: '/friends', component: PageWrapper, props: { wraps: NotFoundPage }, meta: { requiresAuth: true } },
]

var router = new VueRouter({
    mode: 'history',
    base: '/',
    routes: routes
})

router.beforeEach((to, from, next) => {
    const IsItABackButton = window.popStateDetected
    window.popStateDetected = false
    if (IsItABackButton) { // && from.meta.someLogic
        next(false)
        return
    }

    if (to.matched.some(record => record.meta.requiresAuth)) {
        if (store.getters.signedIn) {
            next()
            return
        }
        next(from)
        store.dispatch('openDialog', 'signin')
    } else {
        next()
    }
})

export default router
