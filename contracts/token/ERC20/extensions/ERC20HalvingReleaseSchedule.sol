// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ERC20Capped.sol";
import "../../../access/Ownable.sol";

abstract contract ERC20HalvingReleaseSchedule is ERC20Capped, Ownable {

    /**
    * @notice submit a list of unix timestamps as unlock dates.
    */
    uint[] public unlocks;

    /**
     * @dev See {ERC20-ERC20Capped}.
     */
    constructor(
        string memory _name,
        string memory _symbol,
        uint _cap,
        uint[] memory _unlocks
    ) ERC20Capped(_cap) ERC20(_name, _symbol) {
        unlocks = _unlocks;
    }

    /**
     * @dev Also See {ERC20-Capped Supply _mint}.
     */
    function mint() public onlyOwner {
        uint supplyBefore = totalSupply();
        bool success = false;
        if (block.timestamp > unlocks[unlocks.length - 1]) {
            if (unlocks.length > 1) {
                unlocks.pop();
                _mint(_msgSender(), (cap() - totalSupply()) / 2);
            } else {
                _mint(_msgSender(), (cap() - totalSupply()));
            }
            emit Halvening(supplyBefore, totalSupply());
            success = true;
        }
        require(success == true, 'no halving due');
    }

    event Halvening(uint supplyBefore, uint supplyAfter);

    function unlocksCount() public view returns (uint length){
        return unlocks.length;
    }
}
