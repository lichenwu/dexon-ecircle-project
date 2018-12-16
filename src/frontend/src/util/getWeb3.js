import Web3 from 'web3'
// import { abi } from '../../../build/contracts/Hello';
import abi from './circle_abi.json';

const defaultAddress = "0x09969f1fdb49ae33429c47814af7e94883f8c1ec";

const DEXON_TESTNET_ID = 238;
const INJECTED = window.dexon || window.ethereum;

let store = null;

const contractHandler = {
  getNetworkId() {
    this.walletHandler.eth.net.getId();
  },
  contractInit,
  setStore(newStore) {
    store = newStore;
  },
};

async function contractInit(handler, address = defaultAddress) {
  handler.contract = new handler.walletHandler.eth.Contract(abi, address);

  function handleDeposit(response) {
    console.log(response);
  }

  // setInterval(async function() {
  //   const pastDepositEvents = await handler.contract.subscribe('depositEvent', { fromBlock: 0, toBlock: 'latest' });
  //   pastDepositEvents.forEach(handleDeposit);
  // }, 3000);
  console.log(handler.contract)

  // const depositEvent = handler.contract.methods.deposit();
  // depositEvent.watch(function(error, result) {
  //   console.log(result);
  // });

  handler.contract.events.depositEvent({}, (error, event) => {
    const { returnValues } = event;
    const { amountDEX } = returnValues;
    // const depositAmount = amountDEX / 10 ** 18;

    const depositAmount = window.dekusanWeb3.utils.fromWei(amountDEX.toString(), 'ether')
    store.dispatch('accountStore/setDeposit', depositAmount, { root: true });
  })

  handler.contract.events.supplyEvent({}, (error, event) => {
    console.log('trigger supply');
    const { returnValues } = event;
    const { amountDEX, amountToken } = returnValues;
    // const depositAmount = amountDex / 10 ** 18;
    const depositAmount = window.dekusanWeb3.utils.fromWei(amountDEX.toString(), 'ether')
    // const tokenAmount = amountToken / 10 ** 18;
    const tokenAmount = window.dekusanWeb3.utils.fromWei(amountToken.toString(), 'ether')
    store.dispatch('accountStore/setDeposit', depositAmount, { root: true });
    store.dispatch('accountStore/setToken', tokenAmount, { root: true });
  })
}


async function getWeb3(handler) {
  let web3 = await new Web3(window.dexon);
  window.dekusanWeb3 = web3;

  if (!INJECTED) {
    alert('Please install DekuSan Wallet');
    return;
  }

  handler.web3 = web3;
  handler.walletHandler = web3;
  const netId = await handler.getNetworkId();

  if (
    (netId !== DEXON_TESTNET_ID) &&
    (window.location.hostname !== 'localhost')
  ) {
    alert('Please Select "DEXON Testt Network" in DekuSan wallet');
    return;
  }
  await contractInit(handler, defaultAddress)
  handler.initDone = true;
}

getWeb3(contractHandler);

export default contractHandler