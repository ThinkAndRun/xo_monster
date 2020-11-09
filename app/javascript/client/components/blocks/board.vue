<template>
    <div class="board-area">
        <div class="board d-flex flex-column"
             v-bind:class="[boardIsActive ? 'active' : 'blocked']"
        >
            <board-row
                    v-for="rowNumber in boardHeight"
                    v-bind:cols="boardCols(rowNumber)"
                    v-bind:rowNumber="rowNumber"
            ></board-row>
        </div>
    </div>
</template>

<script>
    export default {
        props: {
            xoSession: Object,
            currentUser: Object,
            slug: String
        },
        data () {
            return {

            }
        },
        channels: {
            'ApplicationCable::XoSessionStepChannel': {
                connected() {},
                rejected() {},
                received(data) {
                    // console.log('got data', data)
                },
                disconnected() {}
            },
            'ApplicationCable::XoSessionChangesChannel': {
                connected() {},
                rejected() {},
                received(data) {
                    // console.log('got data', data)
                    this.$root.$emit('updateXoSession', data)
                },
                disconnected() {}
            }
        },
        mounted() {
            this.$cable.subscribe({
                channel: 'ApplicationCable::XoSessionStepChannel',
                slug: this.slug
            });
            this.$cable.subscribe({
                channel: 'ApplicationCable::XoSessionChangesChannel',
                slug: this.slug
            });
        },
        created() {
            this.$root.$on('makeStep', (data) => {
                if (this.boardIsActive) {
                    // console.log('makeStep', data)
                    this.$cable.perform({
                        channel: 'ApplicationCable::XoSessionStepChannel',
                        action: 'make_step',
                        data: data
                    })
                }
            })


        },
        validations: {

        },
        computed: {
            boardHeight: function() {
                return this.xoSession.settings && this.xoSession.settings.fieldSize && this.xoSession.settings.fieldSize.h || 0
            },
            boardWidth: function() {
                return this.xoSession.settings && this.xoSession.settings.fieldSize && this.xoSession.settings.fieldSize.w || 0
            },
            boardIsActive: function() {
                return ((this.xoSession.current_step_mark === 'X' && this.xoSession.x_user && this.xoSession.x_user.id === this.currentUser.id) ||
                    (this.xoSession.current_step_mark === 'O' && this.xoSession.o_user && this.xoSession.o_user.id === this.currentUser.id) ||
                    (this.xoSession.current_step_mark === 'X' && !this.xoSession.x_user && this.xoSession.o_user.id != this.currentUser.id) ||
                    this.xoSession.current_step_mark === 'O' && !this.xoSession.o_user && this.xoSession.x_user.id != this.currentUser.id) &&
                    !this.xoSession.finished
            }
        },
        methods: {
            boardCols(rowNumber) {
                // console.log('rowNumber', rowNumber)
                let to = rowNumber * this.boardWidth
                let from = (rowNumber - 1) * this.boardWidth
                let result = this.xoSession.board.slice(from, to)
                // console.log('from', from, 'to', to, 'cols', result)
                return result
            },
        }
    }
</script>

<style>

</style>