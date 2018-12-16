pragma solidity ^0.4.25;

contract Hello {
    uint256 public value = 0;

    function update() public {
        value = rand;
    }

    function get() view public returns (uint256) {
        return value;
    }
}
