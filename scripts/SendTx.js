const {BigNumber, ethers} = require("ethers");
require("dotenv").config({ path: __dirname + "/./../.env" });


const API_URL = process.env.ALCHEMY_KEY;
const PRIVATE_KEY = process.env.PRIVATE_KEY;
const CONTRACT_ADDRESS = process.env.CONTRACT_ADDRESS;
const CONTRACT_ABI = require("../artifacts/contracts/Nft.sol/Nft.json");


let customHttpProvider = new ethers.providers.JsonRpcProvider("https://eth-rinkeby.alchemyapi.io/v2/" + API_URL);
// const provider = new ethers.providers.WebSocketProvider(API_URL);

async function addPlayer(tokenId, price,metadatahash) {
  let wallet = new ethers.Wallet(PRIVATE_KEY, customHttpProvider);

  let signer = new ethers.Contract(CONTRACT_ADDRESS, CONTRACT_ABI.abi, wallet);

  const mintNft = await signer.mintNft(tokenId, price,metadatahash);

  // await mintNft.wait();
  console.log("NFT Minted");
  console.log(mintNft);
}

 addPlayer(3, BigNumber.from("500000000000000000"),"QmWu5GsFVEBUiMpdyBLKjQix7PPk8bLioWxXaaNStbRbuy"
);