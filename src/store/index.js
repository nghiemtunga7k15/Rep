import Vue from 'vue'
import Vuex from 'vuex'
import exchange from './modules/dice'
import getters from './getters'

Vue.use(Vuex)

const store = new Vuex.Store({
  modules: {
    exchange
  },
  getters
})

export default store
