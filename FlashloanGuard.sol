// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


abstract contract FlashloanGuard {
    address private _customer;
    uint256 private _blockNumber;

    constructor() {}


    modifier entrance() {
        _customer = tx.origin;
        _blockNumber = block.number;
        _;
    }

    modifier nonFlashloan() {
        if (_customer == tx.origin){
            require(_blockNumber < block.number, "FlashloanGuard: potential flashloan attack");
        }

        _;
    }
}