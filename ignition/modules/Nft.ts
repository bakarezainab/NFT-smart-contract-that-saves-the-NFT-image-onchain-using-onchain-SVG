// This setup uses Hardhat Ignition to manage smart contract deployments.
// Learn more about it at https://hardhat.org/ignition

import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";


const NftModule = buildModule("nftModule", (m) => {

  const nft = m.contract("OnChainNFT" );

  return { nft};
});

export default NftModule;
