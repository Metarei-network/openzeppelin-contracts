// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../token/ERC20/extensions/ERC20BurnableTransfer.sol";

contract ERC20BurnableTransferMock is ERC20BurnableTransfer {
    constructor(
        string memory name,
        string memory symbol,
        address initialAccount,
        uint256 initialBalance
    ) ERC20(name, symbol) {
        _mint(initialAccount, initialBalance);
    }
}
