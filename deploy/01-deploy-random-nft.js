const { network } = require("hardhat")

module.exports = async function(hre){
	const { getNamedAccounts, deployments } = hre
	const { deployer } = await getNamedAccounts()
	const { deploy, log } = deployments
	const chainId = network.config.chainId
	let vrfCoordinatorV2Address, subscriptionId
	const FUND_AMOUNT = "10000000000000000000"

	// if working on a testnet or a mainnet
	// those address will exist
	// otherwise, they won't!!
	if (chainId = 31337){
		// make a fake chainlink VRF node
		const vrfCoordinatorV2Mock = await ethers.getContract("VRFCoordinatorV2Mock")
		vrfCoordinatorV2Address = vrfCoordinatorV2Mock.address
		const tx = await vrfCoordinatorV2Mock.createSubscription()
		const txReceipt = await tx.wait(1)		
		subscriptId = txReceipt.events[0].args.subId
		await vrfCoordinatorV2Mock.fundSubscription(subscriptionId, FUND_AMOUNT)
	} else{
		// use the real one
		vrfCoordinatorV2Address = "0x6168499c0cFfCaCD319c818142124B7A15E857ab"
		subscriptionId = "3491"     // demo ID, should create our own (video 1:20:00 somewhere)
	}
}








































