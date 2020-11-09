<template>
    <div class="text-center">
        <v-dialog v-model="dialogs.signin" max-width="350px" persistent>
            <v-card>
                <form-wrapper :validator="$v.form">
                    <v-form class="form-signin" @submit.prevent="submit">
                        <v-card-title class="headline primary lighten-1 white--text">
                            Sign in
                        </v-card-title>

                        <v-card-text>
                            <v-container>
                                <v-row>
                                    <v-col cols="12">
                                        <form-group name="email">
                                            <template slot-scope="{ attrs }">
                                                <v-text-field
                                                        v-bind="attrs"
                                                        v-model="form.email"
                                                        @input="$v.form.email.$touch()"
                                                        type="email"
                                                        required
                                                >
                                                    <template v-slot:label>
                                                        Email
<!--                                                        <v-icon small style="vertical-align: middle">fas fa-at</v-icon>-->
                                                    </template>
                                                </v-text-field>
                                            </template>
                                        </form-group>
                                        <form-group name="password">
                                            <template slot-scope="{ attrs }">
                                                <v-text-field
                                                        v-bind="attrs"
                                                        v-model="form.password"
                                                        @input="$v.form.password.$touch()"
                                                        type="password"
                                                        required
                                                >
                                                    <template v-slot:label>
                                                        Password
<!--                                                        <v-icon small style="vertical-align: middle">fas fa-key</v-icon>-->
                                                    </template>
                                                </v-text-field>
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
                                                @click.native="openDialog('signup')"
                                                color="primary"
                                                dark
                                                absolute
                                                top
                                                left
                                                fab
                                                v-bind="attrs"
                                                v-on="on"
                                        >
                                            <v-icon>mdi-account-plus</v-icon>
                                        </v-btn>
                                    </v-fab-transition>
                                </template>
                                <span>Sign up</span>
                            </v-tooltip>

                            <v-spacer></v-spacer>

                            <v-btn color="grey" text @click.native="closeAllDialogs">Close</v-btn>
                            <v-btn color="primary" text type="submit" :disabled="$v.form.$invalid">Sign in</v-btn>
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
    import { required, email } from 'vuelidate/lib/validators'

    export default {
        data () {
            return {
                form: { email: '', password: '' }
            }
        },
        validations: {
            form: {
                email: { required, email },
                password: { required }
            }
        },
        computed: {
            ...mapState(['dialogs'])
        },
        methods: {
            ...mapActions(['openDialog', 'closeAllDialogs', 'signIn']),
            submit() {
                let data = { email: this.form.email, password: this.form.password }
                this.signIn(data)
            }
        }
    }
</script>
