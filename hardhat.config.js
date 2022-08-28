/**
* @type import('hardhat/config').HardhatUserConfig
*/

require('dotenv').config();
require("@nomiclabs/hardhat-ethers");

const { ALCHEMY_KEY, PRIVATE_KEY } = process.env;

module.exports = {
   solidity: "0.8.4",
   defaultNetwork: "rinkeby",
   networks: {
    hardhat: {},
    rinkeby: {
      url: "`https://eth-rinkeby.alchemyapi.io/v2/${ALCHEMY_KEY}`",
      accounts: ["`0x${PRIVATE_KEY}`",],
      gasMultiplier: 1,
      gas: 2100000,
      gasPrice: 8000000000,
      timeout: 30000,
      saveDeployments: true,
      chainId: 4,
    },

   
  },
}