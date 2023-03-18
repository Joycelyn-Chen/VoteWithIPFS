//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;


import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";		//interface to import random numbers
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

contract RandomIpfsNft is ERC721URIStorage, VRFConsumerBaseV2{
	VRFCoordinatorV2Interface immutable i_vrfCoordinator;		//immutable bc we 
	bytes32 immutable i_gasLane;
	uint64 immutable i_subscriptionId;
	uint32 immutable i_callbackGasLimit;

	uint16 constant REQUEST_CONFIRMATIONS = 3;
	uint32 constant NUM_WORDS = 1;
	uint256 constant MAX_CHANCE_VALUE = 100;

	mapping(uint256 => address) s_requestIdToSender;
    string[3] s_dogTokenUris;

	uint256 s_tokenCounter;

	constructor(
		address vrfCoordinatorV2, 
		bytes32 gasLane,
		uint64 subscriptionId,
		uint32 callbackGasLimit,
		string[3] memory dogTokenUris
	) ERC721("Random IPFS NFT", "RIN") VRFConsumerBaseV2(vrfCoordinatorV2) {
		i_vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinatorV2);			//interface + address = contract
		i_gasLane = gasLane;						// estimate how much gas we're gonna pay, if too high, then we forget it, we don't want that anymore
		i_subscriptionId = subscriptionId;
		i_callbackGasLimit = callbackGasLimit;
		s_tokenCounter = 0;
		s_dogTokenUris = dogTokenUris;
	}

	// Mint a random puppy
	function requestDoggie() public returns (uint256 requestId){
		requestId = i_vrfCoordinator.requestRandomWords(
			i_gasLane,		// price per gas
			i_subscriptionId,
			REQUEST_CONFIRMATIONS,
			i_callbackGasLimit,				// max gas amount	
			NUM_WORDS
		);
		s_requestIdToSender[requestId] = msg.sender;
	}

	// callback function
	// 100 gas @ 200 gwei / gas

	function fulfillRandomWords(uint256 requestId, uint256[] memory randomWords) internal override{
		// owner of the dog
		address dogOwner = s_requestIdToSender[requestId];

		//assign this NFT a tokenId
		uint256 newTokenId = s_tokenCounter;
		s_tokenCounter = s_tokenCounter + 1;

		// we need randomness


		// get the breed
		uint256 moddedRng = randomWords[0] % MAX_CHANCE_VALUE;
		uint256 breed = getBreedFromModdedRng(moddedRng);
		_safeMint(dogOwner, newTokenId);
		_setTokenURI(newTokenId, s_dogTokenUris[breed]);
	}


	function getChanceArray() public pure returns(uint256[3] memory){
		// 0 - 9 = bernard
		// 


		return [10, 30, MAX_CHANCE_VALUE];
	}

	function getBreedFromModdedRng(uint256 moddedRng) public pure returns (uint256){
		uint256 cumulativeSum = 0;
		uint256[3] memory chanceArray = getChanceArray();

		for (uint256 i = 0; i < chanceArray.length; i++){
			if(moddedRng >= cumulativeSum && moddedRng < cumulativeSum + chanceArray[i]){
				//0 = St.bernard
				//1 = 
				//2 = 
				return i;
			}
			cumulativeSum = cumulativeSum + chanceArray[i];
		}
	}
	
}




































