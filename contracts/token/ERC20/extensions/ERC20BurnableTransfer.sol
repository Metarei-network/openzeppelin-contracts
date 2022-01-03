// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../../../utils/math/SafeMath.sol";
import "./ERC20Burnable.sol";
import "../../../access/Ownable.sol";

/**
 * @dev Extension of ERC20 to support a adjustable transaction tax.
 * The initial rate is set in the constructor thereafter one can set the rate via a call to setBurnFraction()
 */
abstract contract ERC20BurnableTransfer is ERC20Burnable, Ownable {
    using SafeMath for uint;
    uint public burnedAmount;
    uint public burnedFraction;

    /**
     * @dev
     * See also {ERC20-ERC20Capped}.
     */
    constructor(
    ) ERC20Burnable() {
        burnedAmount = 0;
        burnedFraction = 160;
    }

    /**
    * @dev See {IERC20-transfer}.
         *
         * Requirements:
         * - the caller must have a balance of at least `amount`.
         * - a fraction must be burned.
         */
    function transfer(address _recipient, uint _amount) public virtual override returns (bool) {
        (bool a, uint b) = SafeMath.tryDiv(_amount, burnedFraction);
        require(a == true, "error calculating burned amount");
        (bool c, uint d) = SafeMath.trySub(_amount, b);
        require(c == true, "error subtracting burned amount");
        burn(b);
        super.transfer(_recipient, d);
        return true;
    }

    /**
     * @dev Sets `burnedFraction` of each transfer.
     * See {transfer}.
     */
    function setBurnedFraction(uint _burnedFraction) public onlyOwner {
        burnedFraction = _burnedFraction;
    }

    /**
     * @dev Destroys `amount` tokens from the caller and tracks the total burned.
     * See {ERC20-_burn}.
     */
    function burn(uint _amount) public virtual override {
        (bool a, uint b) = SafeMath.tryAdd(burnedAmount, _amount);
        require(a == true, "error burning tokens");
        burnedAmount = b;
        super._burn(_msgSender(), _amount);
    }
}
