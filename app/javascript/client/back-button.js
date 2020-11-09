// This listener will execute before router.beforeEach only if registered
// before vue-router is registered with Vue.use(VueRouter)

window.popStateDetected = false
window.addEventListener('popstate', () => {
    window.popStateDetected = true
})
