/* eslint no-console: 0 */

// Client APP Structure
// ├── router.js # contains routes
// ├── api
// │   └── ...   # abstractions for making API requests
// ├── components
// │   ├── app.vue
// │   └── ...
// └── store
//     ├── index.js          # where we assemble modules and export the store
//     ├── actions.js        # root actions
//     ├── mutations.js      # root mutations
//     └── modules
//         ├── cart.js       # cart module
//         └── products.js   # products module

import Vue from 'vue'
import ClientApp from '../client/components/client-app.vue'

import 'vuetify/dist/vuetify.min.css'
import '@mdi/font/css/materialdesignicons.css'
import '@fortawesome/fontawesome-free/css/all.css'

import VueAxios from 'vue-axios'
import { securedAxiosInstance, plainAxiosInstance } from '../client/axios'
Vue.use(VueAxios, {
  secured: securedAxiosInstance,
  plain: plainAxiosInstance
})

require("../client/back-button")
require("../client/validators")
require("../client/global-components")
require("../client/actioncable")
import vuetify from '../client/vuetify'
import store from '../client/store'
import router from '../client/router'

// APP
Vue.config.productionTip = false
document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    router,
    store,
    securedAxiosInstance,
    plainAxiosInstance,
    vuetify,
    render: h => h(ClientApp)
  }).$mount("#client_app")
  // console.log(app)
})
