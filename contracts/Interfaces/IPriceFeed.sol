// SPDX-License-Identifier: MIT
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

pragma solidity 0.8.17;

interface IPriceFeed {
	struct ChainlinkResponse {
		uint80 roundId;
		int256 answer;
		uint256 timestamp;
		bool success;
		uint8 decimals;
		uint8 originalDecimals;
	}

	struct TellorResponse {
		bool ifRetrieve;
		uint256 value;
		uint256 timestamp;
		bool success;
	}

	struct RegisterOracle {
		AggregatorV3Interface chainLinkOracle;
		bool isRegistered;
		bytes32 tellorId;
	}

	enum Status {
		chainlinkWorking,
		usingTellorChainlinkUntrusted,
		bothOraclesUntrusted,
		usingTellorChainlinkFrozen,
		usingChainlinkTellorUntrusted
	}

	// --- Events ---
	event PriceFeedStatusChanged(Status newStatus);
	event LastGoodPriceUpdated(address indexed token, uint256 _lastGoodPrice);
	event LastGoodIndexUpdated(address indexed token, uint256 _lastGoodIndex);
	event RegisteredNewOracle(address token, address chainLinkAggregator, bytes32 tellorId);

	// --- Function ---
	function addOracle(address _token, address _chainlinkOracle, bytes32 _tellorId) external;

	function fetchPrice(address _token) external returns (uint256);
}
