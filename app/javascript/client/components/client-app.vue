<template>
  <div id="client_app">
    <v-app>
      <router-view></router-view>
      <signin/>
      <signup/>
      <confirm ref="confirm"></confirm>
      <error-snackbar/>
    </v-app>
  </div>
</template>

<script>
export default {
  mounted() {
    this.$root.$confirm = this.$refs.confirm.open

    if (this.$store.state.signedIn) {
      // this.$store.commit('reset')
      // this.$store.dispatch('xoSessions/update')
      // console.log(this.$store.state.xoSessions.data)
    }
  }
}
</script>
