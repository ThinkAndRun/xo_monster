import Vue from 'vue'
import Vuelidate from 'vuelidate'
import VuelidateErrorExtractor, { templates } from 'vuelidate-error-extractor'

const attributes = {
    name: "Name",
    email: "Email",
    password: "Password",
    password_confirmation: "Password confirmation"
}

const messages = {
    required: "{attribute} is required",
    email: "It is not a proper email address",
    minLength: "{attribute} is too short",
    sameAsPassword: "Passwords must be identical"
}

Vue.use(Vuelidate)
Vue.component("formWrapper", templates.FormWrapper)
Vue.use(VuelidateErrorExtractor, {
    messages,
    attributes
})