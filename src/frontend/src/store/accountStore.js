import contractHandler from '../util/getWeb3';


let state = {
  contractInstance: null,
  contractAddress: '',
  balance: 0,
  assets: [
    {
      tokenFullName: 'Cobinhood token(COB)',
      rate: 5,
      balance: 0,
      price: 30,
    },
  ],
};

const actions =  {
  incrementIfOddOnRootSum ({ state, commit, rootState }) {
    if ((state.count + rootState.count) % 2 === 1) {
      commit('increment')
    }
  },

  runDeposit({commit}, amount) {
    contractHandler.contract.methods.deposit().send({
      from: window.dexon.defaultAccount,
      value: window.dekusanWeb3.utils.toWei(amount.toString(), 'ether'),
    });
  },

  runSupply({commit}, amount) {
    console.log('run supply action', amount, contractHandler.contract.methods);
    contractHandler.contract.methods.supply(window.dekusanWeb3.utils.toWei(amount.toString(), 'ether')).send({
      from: window.dexon.defaultAccount,
    });
  },

  setDeposit({commit}, amount) {
    commit('setDeposit', amount);
  },

  setToken({commit}, amount) {
    commit('setToken', amount);
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

  setToken(state, amount) {
    state.assets[0].balance = amount;
  },

  setDeposit(state, amount) {
    state.balance = amount;
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