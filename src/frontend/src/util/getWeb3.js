import Web3 from 'web3'
// import { abi } from '../../../build/contracts/Hello';
import abi from './circle_abi.json';

const defaultAddress = "0x09969f1fdb49ae33429c47814af7e94883f8c1ec";

const DEXON_TESTNET_ID = 238;
const INJECTED = window.dexon || window.ethereum;


const contractHandler = {
  getNetworkId() {
    this.walletHandler.eth.net.getId();
  },
  contractInit,
};

async function contractInit(handler, address = defaultAddress) {
  handler.contract = new handler.walletHandler.eth.Contract(abi, address);

  function handleDeposit(response) {
    console.log(response);

  }

  setInterval(async function() {
    const pastDepositEvents = await this.contract.getPastEvents('depositEvent', { fromBlock: 0, toBlock: 'latest' });
    pastDepositEvents.forEach(handleDeposit);
  }, 3000);
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