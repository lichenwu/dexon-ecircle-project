import Vue from 'vue'
import Vuex from 'vuex'
import accountStore from './accountStore'

Vue.use(Vuex)

export const store = new Vuex.Store({
  strict: true,
  state: {},
  mutations: {},
  actions: {},
  modules: {
    accountStore,
  },
})