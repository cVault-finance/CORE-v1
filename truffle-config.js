const LedgerWalletProvider = require('truffle-ledger-provider');
const INFURA_APIKEY = process.env.INFURA_APIKEY;
const kovanLedgerOptions = {
  networkId: 42, // mainnet
  // path: "44'/60'/0'/0", // ledger default derivation path
  path: "44'/60'/0'/0/0", // ledger default derivation path
  askConfirm: false,
  accountsLength: 1,
  accountsOffset: 0,
};

const kovanProvider = new LedgerWalletProvider(kovanLedgerOptions, `https://kovan.infura.io/v3/${INFURA_APIKEY}`);
const mainnetProvider = new LedgerWalletProvider(kovanLedgerOptions, `https://mainnet.infura.io/v3/${INFURA_APIKEY}`);

module.exports = {
  networks: {
    development: {
      protocol: 'http',
      host: 'localhost',
      port: 8545,
      gas: 5000000,
      gasPrice: 5e9,
      networkId: '*'
    },
    kovan: {
      provider: kovanProvider,
      network_id: 42,
      gas: 4600000,
    },
    kovan: {
      provider: mainnetProvider,
      network_id: 1,
      gas: 4600000,
    }
  },
  compilers: {
    solc: {
      version: "0.6.12",
      docker: false,
      settings: {
       optimizer: {
         enabled: true,
         runs: 200
       },
       evmVersion: "byzantium"
      }
    }
  }
};
