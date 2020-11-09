<template>
    <v-container id="not_found_page" fill-height fluid>
      <v-row align="center" justify="center">
        <v-col  >
          <div class="d-flex flex-column justify-space-between align-center">
            <h1 class="v-heading text-h2 mt-6">404 Not found</h1>
            <p class="text-h5 text-center mt-4 mb-6" style="max-width: 650px;">
              Sorry...
            </p>
            <v-btn
                    rounded
                    color="primary"
                    class="mb-16"
                    x-large
                    dark
                    :to="'/'"
            >
              Go to main page
            </v-btn>
          </div>
        </v-col>
      </v-row>
    </v-container>
</template>

<script>
export default {
  data: function () {
    return {
      message: '404 Not found!'
    }
  }
}
</script>
