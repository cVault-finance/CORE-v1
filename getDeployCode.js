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

const deployTokenFromSigner = (contractABI, contractBytecode, wallet, args = []) => {

    const factory = new ContractFactory(contractABI, contractBytecode)
    let deployTx = factory.getDeployTransaction(...args)
    console.log(deployTx)
    // deployTokenFromSigner(tokenUnpacked.abi, tokenUnpacked.bytecode, provider, tokenArgs)
}

const getContractDeployTx = (contractABI, contractBytecode, wallet, provider, args = []) => {
    const factory = new ContractFactory(contractABI, contractBytecode, wallet.connect(provider))
    let txRequest = factory.getDeployTransaction(...args)
    return txRequest
}

const deployContract = async (contractABI, contractBytecode, wallet, provider, args = []) => {
    const factory = new ContractFactory(contractABI, contractBytecode, wallet.connect(provider))
    return await factory.deploy(...args);
}

const deployCOREToken = async (mnemonic = "", mainnet = false) => {

    // Get the built metadata for our contracts
    let tokenUnpacked = unpackArtifact("./artifacts/CORE.json")
    console.log(tokenUnpacked.description)
    // let chefUnpacked = unpackArtifact("./artifacts/MasterChef.json")
    let feeApproverUnpacked = unpackArtifact("./artifacts/FeeApprover.json")

    let provider;
    let wethAddress;
    const uniswapFactoryAddress = "0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f";
    const uniswapRouterAddress = "0x7a250d5630b4cf539739df2c5dacb4c659f2488d";
    if(mainnet) {
        provider = ethers.getDefaultProvider("homestead")
        wethAddress = "0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2"
    }
    else {
        provider = ethers.getDefaultProvider("kovan")
        wethAddress = "0xd0a1e359811322d97991e03f863a0c30c2cf029c"
    }

    // Do the deployments

    // Create a wallet and connect it to a network
    // First, the token
    // constructor(address router, address factory)
    const tokenArgs = [
        uniswapRouterAddress,
        uniswapFactoryAddress
    ]
    if(mnemonic != "") {
        const wallet = Wallet.fromMnemonic(mnemonic);
        const connectedWallet = wallet.connect(provider);
    }
    else {
        deployTokenFromSigner(tokenUnpacked.abi, tokenUnpacked.bytecode, provider, tokenArgs)
    }
    return;

    // using soft mnemonic
    const token = await deployContract(tokenUnpacked.abi, tokenUnpacked.bytecode, wallet, provider, tokenArgs)
    console.log(`⌛ Deploying token...`)
    await connectedWallet.provider.waitForTransaction(token.deployTransaction.hash)
    console.log(`✅ Deployed token to ${token.address}`)
    return
    console.log(`⌛ calling createUniswapPairMainnet...`)
    let tx = await token.createUniswapPairMainnet();
    console.log(`⌛ createUniswapPairMainnet...`)
    await connectedWallet.provider.waitForTransaction(tx.hash)
    console.log(`✅ Called createUniswapPairMainnet() on token at ${token.address}`)

    const feeApproverArgs = [
        token.address,
        wethAddress,
        uniswapFactoryAddress
    ]

    // Now, the fee approver contract
    const feeApprover = await deployContract(feeApproverUnpacked.abi, feeApproverUnpacked.bytecode, wallet, provider, feeApproverArgs)
    console.log(`⌛ Deploying feeApprover...`)
    await connectedWallet.provider.waitForTransaction(feeApprover.deployTransaction.hash)
    console.log(`✅ Deployed feeApprover.`)
    // Now update the token to refer to the fee approver
    let setTransferCheckerResult = await token.setShouldTransferChecker(feeApprover.address)
    console.log(`⌛ setShouldTransferChecker...`)
    await connectedWallet.provider.waitForTransaction(setTransferCheckerResult.hash)
    console.log(`✅ Called setShouldTransferChecker(${feeApprover.address} on token at ${token.address}`)
    let setFeeBearerResult = await token.setFeeBearer(wallet.address)
    console.log(`⌛ setFeeBearer...`)
    await connectedWallet.provider.waitForTransaction(setFeeBearerResult.hash)
    console.log(`✅ Called setFeeBearer(${wallet.address} on token at ${token.address})`)

    console.log(setTransferCheckerResult)
    console.log(setFeeBearerResult)

    console.log("All done1!")

    console.log("All done!")

}

const deployCoreVault = (coreTokenAddress = "0x62359ed7505efc61ff1d56fef82158ccaffa23d7") => {
    let coreVaultUnpacked = unpackArtifact("./artifacts/FeeApprover.json")
}


// deployCOREToken();
deployCoreVault();
