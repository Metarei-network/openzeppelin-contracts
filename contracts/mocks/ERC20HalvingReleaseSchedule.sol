// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../token/ERC20/extensions/ERC20HalvingReleaseSchedule.sol";

contract ERC20HalvingReleaseScheduleMock is ERC20HalvingReleaseSchedule {
    constructor(
        string memory name,
        string memory symbol,
        uint256 cap,
        uint[] memory _unlocks
    )
    ERC20HalvingReleaseSchedule(
        name,
        symbol,
        cap,
        _unlocks) {

    }
}
