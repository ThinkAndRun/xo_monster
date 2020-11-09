<template>
    <div class="text-center">
        <v-dialog v-model="dialogs.signup" max-width="350px" persistent>
            <v-card>
                <form-wrapper :validator="$v.form">
                    <v-form class="form-signup" @submit.prevent="submit">
                        <v-card-title class="headline primary lighten-1 white--text">
                            Sign up
                        </v-card-title>

                        <v-card-text>
                            <v-container>
                                <v-row>
                                    <v-col cols="12">
                                        <form-group name="name">
                                            <template slot-scope="{ attrs }">
                                                <v-text-field
                                                        v-bind="attrs"
                                                        v-model="form.name"
                                                        @input="$v.form.name.$touch()"
                                                        type="text"
                                                        label="Name"
                                                        required
                                                />
                                            </template>
                                        </form-group>
                                        <form-group name="email">
                                            <template slot-scope="{ attrs }">
                                                <v-text-field
                                                        v-bind="attrs"
                                                        v-model="form.email"
                                                        @input="$v.form.email.$touch()"
                                                        type="email"
                                                        label="Email"
                                                        required
                                                />
                                            </template>
                                        </form-group>
                                        <form-group name="password">
                                            <template slot-scope="{ attrs }">
                                                <v-text-field
                                                        v-bind="attrs"
                                                        v-model="form.password"
                                                        @input="$v.form.password.$touch()"
                                                        type="password"
                                                        label="Password"
                                                        required
                                                />
                                            </template>
                                        </form-group>
                                        <form-group name="password_confirmation">
                                            <template slot-scope="{ attrs }">
                                                <v-text-field
                                                        v-bind="attrs"
                                                        v-model="form.password_confirmation"
                                                        @input="$v.form.password_confirmation.$touch()"
                                                        type="password"
                                                        label="Password confirmation"
                                                        required
                                                />
                                            </template>
                                        </form-group>
                                    </v-col>
                                </v-row>
                            </v-container>

                        </v-card-text>

                        <v-divider></v-divider>

                        <v-card-actions style="position: relative">

                            <v-tooltip right>
                                <template v-slot:activator="{ on, attrs }">
                                    <v-fab-transition>
                                        <v-btn
                                                @click.native="openDialog('signin')"
                                                color="primary"
                                                dark
                                                absolute
                                                top
                                                left
                                                fab
                                                v-bind="attrs"
                                                v-on="on"
                                        >
<!--                                            <v-icon>fas fa-key</v-icon>-->
                                            <v-icon>mdi-key-variant</v-icon>
                                        </v-btn>
                                    </v-fab-transition>
                                </template>
                                <span>Sign in</span>
                            </v-tooltip>

                            <v-spacer></v-spacer>

                            <v-btn color="grey" text @click.native="closeAllDialogs">Close</v-btn>
                            <v-btn color="primary" text type="submit" :disabled="$v.form.$invalid">Sign up</v-btn>
                        </v-card-actions>
                    </v-form>
                </form-wrapper>
            </v-card>
        </v-dialog>
    </div>
</template>

<script>
    import { mapState } from 'vuex'
    import { mapActions } from 'vuex'
    import { required, email, minLength, sameAs } from 'vuelidate/lib/validators'

    export default {
        data () {
            return {
                form: { name: '', email: '', password: '', password_confirmation: '' }
            }
        },
        validations: {
            form: {
                name: { required },
                email: { required, email },
                password: { required, minLength: minLength(8) },
                password_confirmation: { required, sameAsPassword: sameAs('password') }
            }
        },
        computed: {
            ...mapState(['dialogs'])
        },
        methods: {
            ...mapActions(['openDialog', 'closeAllDialogs', 'signUp']),
            submit() {
                let data = {
                    name: this.form.name,
                    email: this.form.email,
                    password: this.form.password,
                    password_confirmation: this.form.password_confirmation
                }
                this.signUp(data)
            },
        }
    }
</script>
