<template>
    <v-snackbar
            v-model="snackbar"
            :timeout="5000"
            content-class="pink--text"
            class="text-uppercase"
    >
        {{ $store.state.error }}

        <template v-slot:action="{ attrs }">
            <v-btn
                    color="pink"
                    text
                    v-bind="attrs"
                    @click="$store.commit('showError', '')"
            >
                Close
            </v-btn>
        </template>
    </v-snackbar>
</template>

<script>
    export default {
        computed: {
            snackbar: {
                get () {
                    return this.$store.state.error.length > 0
                },
                set (value) {
                    this.$store.commit('showError', '')
                }
            }
        }
    }
</script>
