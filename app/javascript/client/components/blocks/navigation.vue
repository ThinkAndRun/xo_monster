<template>
  <div id="navigation" style="display:contents;">
    <v-btn to="/play" color="primary" class="px-2 mx-1" text>New game</v-btn>
    <template v-if="signedIn">
<!--      <v-btn to="/friends" color="primary" class="px-2 mx-1" text>Friends</v-btn>-->
      <v-menu
              v-model="menu"
              :close-on-content-click="false"
              :nudge-width="200"
              offset-x
      >
        <template v-slot:activator="{ on, attrs }">
          <v-btn
                  color="primary"
                  class="ml-2"
                  style="height: 40px; width: 40px;"
                  outlined
                  fab
                  dark
                  v-bind="attrs"
                  v-on="on"
          >
            <span class="headline">{{ currentUserAvatar }}</span>
          </v-btn>
        </template>

        <v-card>
          <v-list>
            <v-list-item>
              <v-list-item-avatar color="primary" size="40" outlined>
                <span class="white--text headline">{{ currentUserAvatar }}</span>
              </v-list-item-avatar>

              <v-list-item-content class="pr-2">
                <v-list-item-title>{{ currentUser.name }}</v-list-item-title>
                <v-list-item-subtitle>{{ currentUser.email }}</v-list-item-subtitle>
              </v-list-item-content>
            </v-list-item>
          </v-list>

          <v-divider></v-divider>

          <v-list>
<!--            <v-list-item link>-->
<!--              <v-list-item-icon>-->
<!--                <v-icon color="primary">mdi-cog</v-icon>-->
<!--              </v-list-item-icon>-->
<!--              <v-list-item-content class="primary&#45;&#45;text">-->
<!--                <v-list-item-title>Settings</v-list-item-title>-->
<!--              </v-list-item-content>-->
<!--            </v-list-item>-->

            <v-list-item link @click.prevent="confirmSignOut">
              <v-list-item-icon>
                <v-icon color="primary">mdi-export</v-icon>
              </v-list-item-icon>
              <v-list-item-content class="primary--text">
                <v-list-item-title>Sign out</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </v-list>
        </v-card>
      </v-menu>


    </template>
    <template v-else>
      <v-btn @click.prevent="openDialog('signin')" color="primary" class="mx-1">
<!--        <v-icon class="mr-2">mdi-key-variant</v-icon>-->
        Sign In
      </v-btn>
    </template>
  </div>
</template>

<script>
  import { mapActions } from 'vuex'
  import { mapState } from 'vuex'
  import { mapGetters } from 'vuex'

  export default {
    data () {
      return {
        menu: false
      }
    },
    computed: {
      ...mapState(['signedIn', 'currentUser']),
      ...mapGetters(['currentUserName', 'currentUserAvatar'])
    },
    methods: {
      ...mapActions(['openDialog', 'signOut']),
      confirmSignOut () {
        this.$root.$confirm('Sign out', 'Are you sure?').then((confirm) => {
          if (confirm) { this.signOut() }
        })
      }
    }
  }
</script>

