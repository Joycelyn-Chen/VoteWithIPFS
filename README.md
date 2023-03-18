# VoteWithIPFS

## Environment Installation
### Yarn
- Execute: `npm install --global yarn`
- Confirm installation with: `yarn --version`
- [Official Installation Guide](https://classic.yarnpkg.com/lang/en/docs/install/#mac-stable)

### Hardhat toolbox
- Run: `npm install --save-dev @nomicfoundation/hardhat-toolbox`
	- `yarn remove ethers` first if versions conflict the ones used in yarn
	- Had to do this cause hardhat has it's own ethers module, otherwise the two would get in each other's way. [Ref source github](https://stackoverflow.com/questions/73431182/cannot-find-module-nomicfoundation-hardhat-toolbox)

- `yarn add --dev @openzeppelin/contracts`
- `yarn add --dev @chainlink/contracts`

```
npm install --save-dev "@nomicfoundation/hardhat-network-helpers@^1.0.0" "@nomicfoundation/hardhat-chai-matchers@^1.0.0" "@types/chai@^4.2.0" "@types/mocha@>=9.1.0" "@typechain/hardhat@^6.1.2" "hardhat-gas-reporter@^1.0.8" "solidity-coverage@^0.8.1" "ts-node@>=8.0.0" "typescript@>=4.5.0"
```

Execute: `yarn add --dev @nomiclabs/hardhat-ethers@npm:hardhat-deploy-ethers ethers @nomiclabs/hardhat-etherscan @nomiclabs/hardhat-waffle chai ethereum-waffle hardhat hardhat-contract-sizer hardhat-deploy hard`