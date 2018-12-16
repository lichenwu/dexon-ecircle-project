let state = {
  web3: {
    isInjected: false,
    web3Instance: null,
    networkId: null,
    coinbase: null,
    balance: null,
    error: null
  },
  contractInstance: null,
  contractAddress: 'Input contract address',
};

const actions =  {
  incrementIfOddOnRootSum ({ state, commit, rootState }) {
    if ((state.count + rootState.count) % 2 === 1) {
      commit('increment')
    }
  },

  setContractAddress({commit}, { contractAddress }) {
    commit('setContractAddress', { contractAddress })
  }
}

const mutations = {
  increment (state) {
    // `state` is the local module state
    state.count++
  },

  setContractAddress(state, { contractAddress }) {
    state.contractAddress = contractAddress;
  }
};

const moduleObj = {
  namespaced: true,
  state,
  mutations,
  actions,
};

 export default moduleObj;