<template>
  <v-main>
    <v-container fill-height fluid>
      <v-row align="center" justify="center">
        <v-col  >

          <div class="d-flex flex-column justify-space-between align-center">
<!--            <img src="~images/xo_monster_logo.png">-->
            <v-img
                    max-height="250"
                    max-width="250"
                    :src="require('images/xo_monster_logo.png')"
            ></v-img>
            <h1 class="v-heading text-h2 mt-6">XO Monster</h1>
            <p class="text-h5 text-center mt-4 mb-6" style="max-width: 650px;">
                The best, most technical advanced, state of art, AAA-class
                Tic-Tac-Toe-like game ever!!!111
            </p>
            <v-btn
                    rounded
                    color="primary"
                    class="mb-16"
                    x-large
                    dark
                    :to="this.$store.state.signInTarget"

            >
<!--                @click="openDialog('signin')"-->
                Join to a Battle!
            </v-btn>
          </div>

        </v-col>
      </v-row>
    </v-container>
  </v-main>
</template>

<script>
import { mapActions } from 'vuex'

export default {
    created () {
        // this.checkSignedIn()
    },
    updated () {
        // this.checkSignedIn()
    },
    methods: {
        ...mapActions(['openDialog', 'checkSignedIn']),
    }
}
</script>

