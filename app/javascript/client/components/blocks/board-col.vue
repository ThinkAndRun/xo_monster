<template>
    <div class="board-col d-flex align-content-center"
         @click="makeStep"
         v-bind:class="[isFilled() ? 'blocked': 'active']"
    >

        <template v-if="mark === 'X'">
            <svg viewBox="0 0 10 10" width="100%" height="100%">
                <line x1="2" y1="2" x2="8" y2="8" stroke="#51206d" strokeWidth="2"/>
                <line x1="2" y1="8" x2="8" y2="2" stroke="#51206d" strokeWidth="2"/>
            </svg>
        </template>
        <template v-else-if="mark === 'O'">
            <svg viewBox="0 0 10 10" width="100%" height="100%">
                <circle cx="5" cy="5" r="3" stroke="#51206d" strokeWidth="2" fill="none"/>
            </svg>
        </template>
        <template v-else>
            {{ mark }}
        </template>
    </div>
</template>

<script>
    export default {
        props: {
            rowNumber: Number,
            colNumber: Number,
            mark: String,
        },
        data () {
            return {
            }
        },
        validations: {

        },
        computed: {

        },
        methods: {
            makeStep() {
                if (this.isFilled()) { return }
                let data = "click to row " + this.rowNumber.toString() + " col " + this.colNumber.toString()
                this.$root.$emit('makeStep', { r: this.rowNumber, c: this.colNumber })
            },
            isFilled() {
                return this.mark == 'X' || this.mark == "O"
            },
        }
    }
</script>

<style>
    .board-col {
        display: -webkit-flexbox;
        display: -ms-flexbox;
        display: -webkit-flex;
        display: flex;
        -webkit-flex-align: center;
        -ms-flex-align: center;
        -webkit-align-items: center;
        align-items: center;
        justify-content: center;

        width: 30px;
        height: 30px;
        outline: 1px solid #9e9e9e;
    }

    .board.active .board-col.active {
        cursor: pointer;
        background-color: white;
    }
    .board.active .board-col.active:hover {
        background-color: wheat;
    }
    .board.active .board-col.blocked {
        background-color: white;
    }
    .board.blocked .board-col {
        background-color: #f3f3f3;
    }
    .board-col-mark {
        display: flex;
        justify-content: center;
    }
</style>