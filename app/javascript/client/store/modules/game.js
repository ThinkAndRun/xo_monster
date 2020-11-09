let defaults = {
    fieldSizeItems: [
        { name: '5x5', value: { h: 5, w: 5 } },
        { name: '10x10', value: { h: 10, w: 10 }, default: true },
        { name: '20x20', value: { h: 20, w: 20 } },
        { name: '50x50', value: { h: 50, w: 50 } },
    ],
    stepLimitItems: [
        { name: '1 min', value: 1 },
        { name: '3 min', value: 3, default: true },
        { name: '5 min', value: 5 },
        { name: '10 min', value: 10 },
    ],
    winLineLimitItems: [
        { name: '3 in row', value: 3 },
        { name: '5 in row', value: 5, default: true },
        { name: '8 in row', value: 8 },
        { name: '12 in row', value: 12 },
    ],
}

let selectedDefaults = {
    fieldSize: defaults.fieldSizeItems.find(item => item.default).value,
    stepLimit: defaults.stepLimitItems.find(item => item.default).value,
    winLineLimit: defaults.winLineLimitItems.find(item => item.default).value,
    vs: null,
}

export let game = {
    namespaced: true,
    state: () => ({
        newGame: {
            settings: {
                defaults: {
                    ...defaults
                },
                selected: {
                    ...selectedDefaults
                }
            }
        }
    }),
    mutations: {
        updateNewGameSettings(state, payload) {
            Object.keys(payload).forEach(key => {
                state.newGame.settings.selected[key] = payload[key]
            })
        }
    },
    actions: {
        reset({ commit }) {
            commit('updateNewGameSettings', selectedDefaults)
        },
        updateNewGameSettings({ commit }, payload) {
            commit('updateNewGameSettings', payload)
        }
    }
}