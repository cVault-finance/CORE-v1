const { ethers, Wallet, ContractFactory, Provider } = require("ethers");
const fs = require('fs');

const unpackArtifact = (artifactPath) => {
    let contractData = JSON.parse(fs.readFileSync(artifactPath))
    const contractBytecode = contractData['bytecode']
    const contractABI = contractData['abi']
    const constructorArgs = contractABI.filter((itm) => {
        return itm.type == 'constructor'
    })
    let constructorStr;
    if(constructorArgs.length < 1) {
        constructorStr = "    -- No constructor arguments -- "
    }
    else {
        constructorJSON = constructorArgs[0].inputs
        constructorStr = JSON.stringify(constructorJSON.map((c) => {
            return {
                name: c.name,
                type: c.type
            }
        }))
    }
    return {
        abi: contractABI,
        bytecode: contractBytecode,
        description:`  ${contractData.contractName}\n    ${constructorStr}`
    }
}

const logDeployTx = (contractABI, contractBytecode, args = []) => {
    const factory = new ContractFactory(contractABI, contractBytecode)
    let deployTx;
    if(args.length === 0) {
        deployTx = factory.getDeployTransaction()
    }
    else {
        deployTx = factory.getDeployTransaction(...args)
    }
    console.log(deployTx)
}

const getContractDeploymentTxFor = async (artifactPath, args) => {
    // Get the built metadata for our contracts
    let contractUnpacked = unpackArtifact(artifactPath)
    console.log(contractUnpacked.description)
    logDeployTx(contractUnpacked.abi, contractUnpacked.bytecode, args)
}



// fill out data for steps as you go
let deployedProxyAdminAddress = "0x9cb1eeccd165090a4a091209e8c3a353954b1f0f";
let deployedCoreVaultAddress = "0xd0ea2a4771e7ce09f2cc02d69ebf9d41a85cf161";
let deployedProxy = "0xc5cacb708425961594b63ec171f4df27a9c0d8c9";
let deployedFeeApprover = "0x1d0db0a5f9f8cf5b69f804d556176c6bc9186587";
// let deployedProxyAdminAddress = "0x08f4aa2e28d4319059a4d5153388c6bf9feccabe"
// let deployedCoreVaultAddress = "0x866c25e8c18c6f2824452163fc8f99f8a1da04ef"
// let deployedProxy = "0xac6bb145d749fd867d383c5779f6adae0a12c291"
let coreTokenAddress = "0x62359ed7505efc61ff1d56fef82158ccaffa23d7"
let devAddr = "0x5A16552f59ea34E44ec81E58b3817833E9fD5436"

// Step 1.
// Deploy proxy admin contract and get the address..
if(!deployedProxyAdminAddress) {
    getContractDeploymentTxFor(
        "./prodartifacts/ProxyAdmin.json"
    );
    return;
}

// Step 2.
// Deploy the CoreVault logic
if(!deployedCoreVaultAddress) {
    getContractDeploymentTxFor(
        "./prodartifacts/CoreVault.json"
    )
    return;
}

// Step 3.
// Deploy the proxy for CoreVault logic
if(!deployedProxy) {
    getContractDeploymentTxFor(
        "./build/contracts/AdminUpgradeabilityProxy.json",
        [
            deployedCoreVaultAddress, /*logic*/
            deployedProxyAdminAddress, /*admin*/
            []
            // ["64c0c53b8b", coreTokenAddress, devAddr, devAddr]
            /*[1,2,3] skip initialization */
        ]
    );
    return;
}

// Step 4.
// Call initializer on the proxied CoreVault

// Step 5.
// Release FeeApprover
if(!deployedFeeApprover) {
    getContractDeploymentTxFor(
        "./prodartifacts/FeeApprover.json"
    )
    return;
}