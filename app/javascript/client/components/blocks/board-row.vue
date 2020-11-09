<template>
    <div class="board-row d-flex justify-center flex-row">
        <board-col
            v-for="(col, index) in cols"
            v-bind:rowNumber="rowNumber"
            v-bind:colNumber="index+1"
            v-bind:mark="col"
        ></board-col>
    </div>
</template>

<script>
    export default {
        props: {
            cols: Array,
            rowNumber: Number,
        },
        data () {
            return {

            }
        },
        created(){

        },
        validations: {

        },
        computed: {

        },
        methods: {
        }
    }
</script>

<style>

</style>