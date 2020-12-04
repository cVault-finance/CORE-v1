# How to build

Here to fork CORE? I wish you the best of luck. Please add build steps in your fork and open a PR. It's the least you can do, right?

# Introducing CORE

CORE is a *non-inflationary* *cryptocurrency* that is designed to execute profit-generating strategies autonomously with a completely decentralized approach. In existing autonomous strategy-executing platforms a team or single developer is solely responsible for determining how locked funds are used to generate ROI. This is hazardous to the health of the fund as it grows, as it creates flawed incentives, and invites mistakes to be made. CORE does away with this dynamic and instead opts for one with decentralized governance.

CORE tokens holders will be able to provide strategy contracts and vote on what goes live and when, in order to decentralize autonomous strategy execution. 5% of all profits generated from these strategies are used to auto market-buy the CORE token.

## Live Contracts

*NEW*

FannyVault Proxy:
- [FannyVault (Proxied) - 0xbb791bc6106e4d949863e2ab76fc01ac0a9d7816](https://etherscan.io/address/0xbb791bc6106e4d949863e2ab76fc01ac0a9d7816)

LGE 3:
- [CORE LGE III (Proxied) - 0xaac50b95fbb13956d7c45511f24c3bf9e2a4a76b](https://etherscan.io/address/0xaac50b95fbb13956d7c45511f24c3bf9e2a4a76b)
- [Fork Absorption Migrator (Proxied) - 0x5dca4093bfe88d6fd5511fb78f6a777d47314d35](https://etherscan.io/address/0x5dca4093bfe88d6fd5511fb78f6a777d47314d35)

CORE v2:
- [CORE LGE II Proxy - 0xf7ca8f55c54cbb6d0965bc6d65c43adc500bc591](https://etherscan.io/address/0xf7ca8f55c54cbb6d0965bc6d65c43adc500bc591)
- [CORE LGE II Implementation - 0x87Cde0888282084c4676FE973b62A10199297597](https://etherscan.io/address/0x87Cde0888282084c4676FE973b62A10199297597)
- [CORE v2 Globals Proxy - https://etherscan.io/address/0x255ca4596a963883afe0ef9c85ea071cc050128b](https://etherscan.io/address/0x255ca4596a963883afe0ef9c85ea071cc050128b)
- [CORE v2 Globals Implementation - 0xe22bbd638b24165206314f999ae27fec9e70dcf6](https://etherscan.io/address/0xe22bbd638b24165206314f999ae27fec9e70dcf6)
- [cBTC Proxy: 0x7b5982dcab054c377517759d0d2a3a5d02615ab8](https://etherscan.io/address/0x7b5982dcab054c377517759d0d2a3a5d02615ab8)
- [cBTC Implementation: 0xf3d513fa681ff6f8f7557533d19aea6a20b961f2](https://etherscan.io/address/0xf3d513fa681ff6f8f7557533d19aea6a20b961f2)

 - [TransferHandler01 Implementation - 0x025b275DD3b79Dc3b79E3F60D0A46516D2396059](https://etherscan.io/address/0x025b275dd3b79dc3b79e3f60d0a46516d2396059)
 - [TransferHandler01 Proxy - 0x2e2A33CECA9aeF101d679ed058368ac994118E7a](https://etherscan.io/address/0x2e2A33CECA9aeF101d679ed058368ac994118E7a)

COREv1Router:
 - [CORE v1 Router Proxy - 0x0ee460204887d98c297bb431e40b713f63ba78e0](https://etherscan.io/address/0x0ee460204887d98c297bb431e40b713f63ba78e0)
 - [CORE v1 Router Original Implementation - 0xbeb3075d3c231d23b03face34f50edf1f8d53a77](https://etherscan.io/address/0xbeb3075d3c231d23b03face34f50edf1f8d53a77)

CORE Contracts:
 - [CORE Token - 0x62359ed7505efc61ff1d56fef82158ccaffa23d7](https://etherscan.io/address/0x62359ed7505efc61ff1d56fef82158ccaffa23d7)
 - [CoreVault (Proxied) - 0xc5cacb708425961594b63ec171f4df27a9c0d8c9](https://etherscan.io/address/0xc5cacb708425961594b63ec171f4df27a9c0d8c9)
 
 Governance Contracts:
 - [CoreVault Original Implementation - 0xd0ea2a4771e7ce09f2cc02d69ebf9d41a85cf161](https://etherscan.io/address/0xd0ea2a4771e7ce09f2cc02d69ebf9d41a85cf161)
 - [Fee Approver - 0x1d0db0a5f9f8cf5b69f804d556176c6bc9186587](https://etherscan.io/address/0x1d0db0a5f9f8cf5b69f804d556176c6bc9186587)
 - [Team Proxy Admin - 0x9cb1eeccd165090a4a091209e8c3a353954b1f0f](https://etherscan.io/address/0x9cb1eeccd165090a4a091209e8c3a353954b1f0f)

Ecosystem Contracts:
 - [Uniswap CORE/WETH UNI-V2 LP Token Contract](https://etherscan.io/address/0x32ce7e48debdccbfe0cd037cc89526e4382cb81b)


# Initial Distribution

The CORE team is kickstarting the initial distribution with a liquidity event. Contribute ETH to the CORE Fair Launch smart contract to receive tokens, and the contributed ETH will be matched and added to the Uniswap liquidity pool. Note that once added, liquidity tokens can not be removed from the CORE Uniswap LP pools. This is by design. Read on to learn about why..

# **Deflationary Farming**

Farming tokens have a problem for their owners. To keep users farming, they have to mint more ever more coins. This completely destroys the value of the underlying token, due to excessive inflation. It's easy to find examples of this across the DeFi ecosystem. 

Our solution is called deflationary farming, and it is quite simple in only two steps:

1. Charge a fee on token transfers
2. Users can earn the fee by farming

This simple process means that those holding tokens are able to farm without infinite inflation.

# Keeping **Liquidity Liquid**

All transfers have to be approved by the CORE Transfers smart contract, which will block all
liquidity withdrawals from Uniswap. This will guarantee a stable market, giving holders and farmers skin in the game.

# **Real Governance**

CORE is designed for great community governance. The communtiy decides everything, from developer fees, to deciding on the fee approver contract, adding new pools, rebalancing, and even disabling pools in the CORE Transfer contract.

If the holders decide COREVault should have a YFI pool, we can set
the ratio of fees it will be able to distribute, as well as when people should be
able to withdraw YFI tokens from it.

This creates an incentive to hold even more CORE by the holders of YFI tokens. Let the governance begin.

# **10000 CORE Forever**

Theres absolutely no way to create new CORE tokens. This means the
circulating supply can only ever go down, period.


## Testing 

To run the tests run
``` npx buidler test ```
