import Vue from 'vue'
import ActionCableVue from 'actioncable-vue'
import store from './store'

function urlWithToken() {
    let storeData = JSON.parse(localStorage.getItem('xoMonster'))
    let token = storeData ? storeData['access'] : ''
    return `wss://${window.location.host}/cable?token=${token}`
}

Vue.use(ActionCableVue, {
    debug: true,
    debugLevel: 'error',
    connectionUrl: urlWithToken(), // or function which returns a string with your JWT appended to your server URL as a query parameter
    connectImmediately: true,
    store
})
