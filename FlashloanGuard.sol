// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


abstract contract FlashloanGuard {
    address private _customer;
    uint256 private _blockNumber;

    constructor() {}
    
    //When a fund is deposited into a smart contract, 
    //it stores the address that started the transaction and the current block number. 
    modifier entrance() {
        _customer = tx.origin;
        _blockNumber = block.number;
        
        _;
    }
    
    //When a fund is being withdrawn, it checks the address that sent the transaction against the stored address. 
    //If these two addresses match, the current block number must be strictly greater than the stored block number. 
    modifier nonFlashloan() {
        if (_customer == tx.origin){
            require(_blockNumber < block.number, "FlashloanGuard: potential flashloan attack");
        }

        _;
    }
}
