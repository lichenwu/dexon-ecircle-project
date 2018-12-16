import contractHandler from '../util/getWeb3';

let state = {
  contractInstance: null,
  contractAddress: '',
  balance: 0,
};

const actions =  {
  incrementIfOddOnRootSum ({ state, commit, rootState }) {
    if ((state.count + rootState.count) % 2 === 1) {
      commit('increment')
    }
  },

  async runDeposit({commit}, amount) {
    await contractHandler.contract.methods.deposit().send({
      from: window.dexon.defaultAccount,
      value: amount * ( 10 ** 18 ),
    });
    commit('setDeposit', amount)
  },

  setContractAddress({commit}, { contractAddress }) {
    commit('setContractAddress', { contractAddress })
    contractHandler.contractInit(contractHandler, contractAddress);
  }
}

const mutations = {
  increment (state) {
    // `state` is the local module state
    state.count++
  },

  setDeposit(state, amount) {
    state.balance += amount;
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