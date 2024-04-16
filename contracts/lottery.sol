
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.7.0 <0.9.0;

contract Lottery {

  address public manager;
  address payable[] public players;
  address payable public winner;

  constructor() {
    manager = msg.sender;
  }
}