// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisValidatorSet {
    address[] public validators;
    mapping(address => bool) public isValidator;

    event ValidatorAdded(address indexed validator);
    event ValidatorRemoved(address indexed validator);

    function addValidator(address validator) external {
        require(!isValidator[validator], "Already validator");
        validators.push(validator);
        isValidator[validator] = true;
        emit ValidatorAdded(validator);
    }

    function removeValidator(address validator) external {
        require(isValidator[validator], "Not validator");
        isValidator[validator] = false;
        for (uint256 i = 0; i < validators.length; i++) {
            if (validators[i] == validator) {
                validators[i] = validators[validators.length - 1];
                validators.pop();
                break;
            }
        }
        emit ValidatorRemoved(validator);
    }
}
