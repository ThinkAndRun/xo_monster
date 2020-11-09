<template>
    <div class="form-group">
        <slot :attrs="{ errorMessages: activeErrorMessages, success: isValid }"
              :hasErrors="hasErrors"
        />
    </div>
</template>
<script>
    import { singleErrorExtractorMixin } from 'vuelidate-error-extractor'
    export default {
        extends: singleErrorExtractorMixin
    }
</script>


<style scoped>
    .form-group >>> .v-icon {
        color: inherit;
    }
</style>