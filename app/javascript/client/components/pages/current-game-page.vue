<template>
  <v-container id="current_game_page" fill-height fluid>
    <v-row align="center" justify="center">
      <v-col  >
        <div class="d-flex flex-column justify-space-between align-center">
          <v-container>
            <v-row
              align="center"
              no-gutters
              style="height: 150px;"
            >
              <v-col class="col-5">
                <v-card
                        class="pa-2 text-right"
                        flat
                >
                  <span class="v-heading text-h4 primary--text">{{ xPlayerName }}</span>
                </v-card>
              </v-col>
              <v-col class="col-2">
                <v-card
                        class="pa-2 text-center"
                        flat
                >
                  <span
                          class="v-heading text-h2 text-no-wrap font-weight-bold pink--text font-italic"
                          style="text-shadow: 1px 1px 2px #51206d, 0 0 1em red; margin-right: 10px;"
                  >VS</span>
                </v-card>
              </v-col>
              <v-col class="col-5">
                <v-card
                        class="pa-2 mt-2 text-left"
                        style="background-color: transparent;"
                        flat
                >
                  <span class="v-heading text-h4 primary--text">{{ oPlayerName }}</span>
                </v-card>
              </v-col>
            </v-row>

            <board
                    v-bind:xoSession="xoSession"
                    v-bind:slug="$route.params.slug"
                    v-bind:currentUser="currentUser"
            ></board>

            <!--          <h1 class="v-heading text-h2 grey&#45;&#45;text">Game {{ $route.params.slug }}</h1>-->


            <template v-if="!!winnerName">
              <div class="d-flex justify-center ma-10">
                <p><strong class="text-uppercase pink--text">{{ winnerName }}</strong> won the game! <v-icon color="pink">mdi-party-popper</v-icon></p>
              </div>
            </template>

            <template v-if="!winnerName && this.xoSession.finished">
              <div class="d-flex justify-center ma-10">
                <p><strong class="text-uppercase pink--text">TIE</strong> let's try again! <v-icon color="pink">mdi-autorenew</v-icon></p>
              </div>
            </template>


          </v-container>



        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapState } from 'vuex'
import * as api from '../../api'
import router from "../../router";

export default {
  channels: {
    ClientFriendsChannel: {
      connected() {},
      rejected() {},
      received(data) {},
      disconnected() {}
    }
  },
  data: function () {
    return {
      xoSession: {},
      defaultYourName: 'You, our Hero',
      defaultOpponentName: 'Anybody'
    }
  },
  computed: {
    ...mapState(['signedIn', 'currentUser']),
    winnerName: function() {
      if (this.xoSession.winner_mark == "X") {
        return this.xPlayerName
      } else if (this.xoSession.winner_mark == "O") {
        return this.oPlayerName
      } else {
        return null
      }
    },
    xPlayerName: function () {
      if (this.xoSession.x_user) {
        if (this.xoSession.x_user.id == this.currentUser.id) {
          return this.defaultYourName
        } else {
          return this.xoSession.x_user.player_name
        }
      } else {
        return this.defaultOpponentName
      }
    },
    oPlayerName: function () {
      if (this.xoSession.o_user) {
        if (this.xoSession.o_user.id == this.currentUser.id) {
          return this.defaultYourName
        } else {
          return this.xoSession.o_user.player_name
        }
      } else {
        return this.defaultOpponentName
      }
    },
  },
  mounted() {
  },
  created () {
    this.loadXoSession(this.$route.params.slug)
    this.$root.$on('updateXoSession', (data) => {
      this.xoSession = JSON.parse(data)
    })
  },
  updated () {
  },
  methods: {
    loadXoSession(slug) {
      api.xoSessionsService.show(slug)
          .then((response) => {
            // console.log(response.data['xo_session'])
            this.xoSession = response.data['xo_session']
          })
          .catch((error) => {
            this.$router.replace('/')
          })
    },
  }
}
</script>

<style scoped>

</style>