
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.7.0 <0.9.0;

contract Lottery {

  address public manager;
  address payable[] public players;
  address payable public winner;

  constructor() {
    manager = msg.sender;
  }

  function participate() public payable {
     require(msg.value==1 ether, "you have to submit 1 ether");
     players.push(payable(msg.sender));
  }

  function getBalance() public view returns(uint256){
    require(manager==msg.sender, "you are not the manager");
    return address(this).balance;
  }

  function random() internal view returns(uint256){
   return uint(keccak256 (abi.encodePacked(block.prevrandao, block.timestamp, players.length)));
  }

  function pickWinner() public {
    require (manager==msg.sender, "you are not the manager");
    require(players.length>=3, "Player are less than 3");

    uint256 rand = random();
    uint256 index = rand%players.length;
    winner = players[index];
    players = new address payable [](0);
  }

  function payWinner() public {
    uint256 transferWinner = address(this).balance;

    (bool success,) = msg.sender.call{value: transferWinner}("");
    require(success, "not transfer to the winner");
  }

}