module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*" // Match any network id
    }
  },
  compilers: {
    solc: {
      version: "0.5.3",
      docker: false,
      settings: {
       optimizer: {
         enabled: true,
         runs: 200
       }
      }
    }
  }
};
