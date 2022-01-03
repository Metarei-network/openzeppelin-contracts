// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../access/Ownable.sol";

abstract contract DisposableAccessCode is Ownable {

    bytes32 private code;
    bool public isPrivate;

    /**
    *  @dev Modifier makes a function accessible when the users passphrase is correct. 
    *  This is a single use code, after use it can be read from the transaction history so the sale contract should only contain the user(s) bid.
    *
    *  Javascript 
    *  
    *  to set the code: -
    *  const bytes32 = Web3.utils.asciiToHex($PASS_PHRASE);
    *  let passphrase = web3.eth.abi.encodeParameter('bytes32', Web3.utils.soliditySha3({
    *      type: 'bytes32',
    *      value: bytes32
    *  }));
    *
    *  @notice To submit a passcode: -
    *  Web3.utils.asciiToHex($PASS_PHRASE);
    */
    modifier  maybePrivate(bytes32 _phrase) {
        if (isPrivate) {
            require(code == keccak256(abi.encodePacked(_phrase)), "The passphrase must be correct");
        }
        _;}

    constructor() {
        isPrivate = true;
    }

    /**
  * @dev Set an encoded passphrase for the private sale.
     */
    function setCode(bytes32 _code) public onlyOwner {
        code = _code;
    }

    /**
  * @dev Determines if the sale is public or private.
     */
    function setPrivate(bool _isPrivate) public onlyOwner {
        isPrivate = _isPrivate;
    }
}
