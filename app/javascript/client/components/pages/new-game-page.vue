<template>
  <v-container id="new_game_page" fill-height fluid>
    <v-row align="center" justify="center">
      <v-col  >
        <div class="d-flex flex-column justify-space-between align-center">
          <h1 class="v-heading text-h2 grey--text">Let's go, XO XO XO</h1>
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
                  <span class="v-heading text-h4 primary--text">You, our Hero</span>
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
                  <span class="v-heading text-h4">
                        <v-select
                                height="40"
                                class="text-h4"
                                style="width: 250px"
                                :disabled="true"
                                item-text="name"
                                item-value="value"
                                v-model="vsFriend"
                                :items="vsFriends"
                        >
                        </v-select>
                    <!--                    :disabled="!signedIn"-->
                  </span>
                </v-card>
              </v-col>
            </v-row>

          </v-container>
          <div style="position: relative" class="mb-16" >
            <v-btn
                    rounded
                    color="primary"
                    x-large
                    dark
                    @click="startNewGame"
            >
              Start the battle
            </v-btn>

            <v-menu
                    v-model="gameSettings.show"
                    :close-on-content-click="false"
                    :nudge-width="200"
                    offset-x
            >
              <template v-slot:activator="{ on, attrs }">
                <v-btn
                        class="ma-2"
                        style="height: 36px; width: 36px;"
                        text
                        fab
                        dark
                        absolute
                        color="white"
                        v-bind="attrs"
                        v-on="on"
                        @click.native="restoreSettings"
                >
                  <v-icon dark x-large color="grey">
                    mdi-cog
                  </v-icon>
                </v-btn>
              </template>

              <v-form @submit.prevent="submit">
                <v-card>
                  <v-card-title>Settings</v-card-title>
                  <v-divider></v-divider>

                  <v-card-text>
                    <form-group name="field_size">
                      <template slot-scope="{ attrs }">
                        <v-select
                                v-bind="attrs"
                                @input="$v.gameSettings.form.fieldSize.$touch()"
                                item-text="name"
                                item-value="value"
                                v-model="gameSettings.form.fieldSize"
                                :items="fieldSizeItems"
                                label="Field size"
                        />
                      </template>
                    </form-group>
                    <form-group name="win_line_limit">
                      <template slot-scope="{ attrs }">
                        <v-select
                                v-bind="attrs"
                                @input="$v.gameSettings.form.winLineLimit.$touch()"
                                item-text="name"
                                item-value="value"
                                v-model="gameSettings.form.winLineLimit"
                                :items="winLineLimitItems"
                                label="WinLine limit"
                        />
                      </template>
                    </form-group>
<!--                    <form-group name="step_limit">-->
<!--                      <template slot-scope="{ attrs }">-->
<!--                        <v-select-->
<!--                                v-bind="attrs"-->
<!--                                @input="$v.gameSettings.form.stepLimit.$touch()"-->
<!--                                item-text="name"-->
<!--                                item-value="value"-->
<!--                                v-model="gameSettings.form.stepLimit"-->
<!--                                :items="stepLimitItems"-->
<!--                                label="Step limit"-->
<!--                        />-->
<!--                      </template>-->
<!--                    </form-group>-->
                  </v-card-text>

                  <v-card-actions>
                    <v-btn
                            color="primary"
                            dark
                            outlined
                            block
                            type="submit"
                    >
                      <v-icon left>
                        mdi-content-save-cog
                      </v-icon>
                      Save
                    </v-btn>
                  </v-card-actions>
                </v-card>
              </v-form>

            </v-menu>
          </div>

        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { required } from 'vuelidate/lib/validators'
import { mapState, mapActions, mapGetters } from 'vuex'
import router from "../../router";

export default {
  data: function () {
    return {
      gameSettings: {
        show: false,
        form: {
          fieldSize: null,
          stepLimit: null,
          winLineLimit: null
        },
        vs: null
      }
    }
  },
  validations: {
    gameSettings: {
      form: {
        fieldSize: { required },
        stepLimit: { required },
        winLineLimit: { required }
      }
    }
  },
  computed: {
    ...mapState(['signedIn', 'currentUser']),
    ...mapState('game', {
      fieldSizeItems: state => state.newGame.settings.defaults.fieldSizeItems,
      stepLimitItems: state => state.newGame.settings.defaults.stepLimitItems,
      winLineLimitItems: state => state.newGame.settings.defaults.winLineLimitItems,
      fieldSize: state => state.newGame.settings.selected.fieldSize,
      stepLimit: state => state.newGame.settings.selected.stepLimit,
      winLineLimit: state => state.newGame.settings.selected.winLineLimit,
      vs: state => state.newGame.settings.selected.vs,
    }),
    vsFriend: {
      get() { return this.vs },
      set(value) { this.updateNewGameSettings({ vs: value }) }
    },
    ...mapGetters('friends', ['vsFriends'])
  },
  created () {
    this.updateFriends()
  },
  updated () {
  },
  methods: {
    ...mapActions('friends', {
      updateFriends: 'update'
    }),
    ...mapActions('xoSessions', {
      createXoSession: 'create'
    }),
    ...mapActions('game', ['updateNewGameSettings']),
    submit() {
      this.updateNewGameSettings(this.gameSettings.form)
      this.gameSettings.show = false
    },
    restoreSettings() {
      this.gameSettings.form.fieldSize = this.fieldSize
      this.gameSettings.form.stepLimit = this.stepLimit
      this.gameSettings.form.winLineLimit = this.winLineLimit
    },
    startNewGame() {
      let params = {
        settings: {
          fieldSize: this.fieldSize,
          stepLimit: this.stepLimit,
          winLineLimit: this.winLineLimit
        },
        o_user_id: this.vsFriend
      }
      this.createXoSession(params).then(xoSession => {
        console.log(xoSession)
        router.replace('/game/' + xoSession.slug)
      })
    }
  }
}
</script>

<style scoped>
#new_game_page >>> .v-select__selection--comma  {
  height: 40px;
  padding-top: 10px;
  color: #51206d !important;
  caret-color: #51206d !important;
}
</style>
