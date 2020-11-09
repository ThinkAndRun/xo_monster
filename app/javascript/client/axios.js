import axios from 'axios'
const API_URL = '/client_api/v1/'
import store from './store'

const securedAxiosInstance = axios.create({
    baseURL: API_URL,
    withCredentials: true,
    headers: {
        'Content-Type': 'application/json'
    }
})

const plainAxiosInstance = axios.create({
    baseURL: API_URL,
    withCredentials: true,
    headers: {
        'Content-Type': 'application/json'
    }
})

securedAxiosInstance.interceptors.request.use(config => {
    const method = config.method.toUpperCase()
    if (method !== 'OPTIONS' && method !== 'GET') {
        config.headers = {
            ...config.headers,
            'X-CSRF-TOKEN': store.state.csrf
        }
    }
    return config
})

securedAxiosInstance.interceptors.response.use(null, error => {
    if (error.response && error.response.config && error.response.status === 401) {
        // In case 401 is caused by expired access cookie - we'll do refresh request
        return plainAxiosInstance.post('/refresh', {}, { headers: { 'X-CSRF-TOKEN': store.state.csrf } })
            .then(response => {
                store.commit('refresh', { csrf: response.data.csrf, access: response.data.access })
                // And after successful refresh - repeat the original request
                let retryConfig = error.response.config
                retryConfig.headers['X-CSRF-TOKEN'] = store.state.csrf
                return plainAxiosInstance.request(retryConfig)
            }).catch(error => {
                store.commit('unsetCurrentUser')
                // redirect to signin in case refresh request fails
                location.replace('/')
                return Promise.reject(error)
            })
    } else {
        return Promise.reject(error)
    }
})

export { securedAxiosInstance, plainAxiosInstance }
