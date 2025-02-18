// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;
import "../Dependencies/CheckContract.sol";
import "../Dependencies/ERC20Permit.sol";

contract YOUToken is CheckContract, UERC20Permit {

	// uint for use with SafeMath
	uint256 internal _1_MILLION = 1e24; // 1e6 * 1e18 = 1e24

	address public immutable treasury;

	constructor(
		address _treasurySig
	) UERC20Permit("Your Omnichain U Protocol Governance Token", "YOU", 18, 0x3c2269811836af69497E5F486A85D7316753cf62) {
		require(_treasurySig != address(0), "Invalid Treasury Sig");
		treasury = _treasurySig;

		//Lazy Mint to setup protocol.
		//After the deployment scripts, deployer addr automatically send the fund to the treasury.
		_mint(msg.sender, _1_MILLION * 500);
		_mint(_treasurySig, _1_MILLION * 500);
	}
}
