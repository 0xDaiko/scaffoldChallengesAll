// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "hardhat/console.sol";
import "./ExampleExternalContract.sol";

contract Staker {

  ExampleExternalContract public exampleExternalContract;

  constructor(address exampleExternalContractAddress) public {
      exampleExternalContract = ExampleExternalContract(exampleExternalContractAddress);
  }

  // Collect funds in a payable `stake()` function and track individual `balances` with a mapping:
  mapping(address => uint256) public balances;
  uint256 public constant threshold = 1 ether;
  event Stake(address,uint256);

  receive() external payable{
    stake();
  }

  function stake() public payable{
    balances[msg.sender] += msg.value;
    emit Stake(msg.sender, msg.value);
  }
  //  ( make sure to add a `Stake(address,uint256)` event and emit it for the frontend <List/> display )


  // After some `deadline` allow anyone to call an `execute()` function
  //  It should either call `exampleExternalContract.complete{value: address(this).balance}()` to send all the value
  bool public openForWithdraw = false;
 bool public hasExecuted = false; 

  uint256 public deadline = block.timestamp + 72 hours;

  function execute() public notCompleted {
    if(address(this).balance >= threshold && block.timestamp >= deadline){
      exampleExternalContract.complete{value: address(this).balance}();
    }
    if(address(this).balance < threshold && block.timestamp >= deadline){
      openForWithdraw = true;
    }
    hasExecuted = true;
  }

  // if the `threshold` was not met, allow everyone to call a `withdraw()` function


  // Add a `withdraw(address payable)` function lets users withdraw their balance

  modifier notCompleted(){
    require(!hasExecuted, "The staking period is over");
    _;
  }

  function withdraw(address payable _to) public notCompleted{
    require(openForWithdraw, "Contract not open for withdraw");
    uint256 userVal = balances[_to];
    
    balances[_to] = 0;
    (bool success,) = _to.call{value: userVal}("");
    require(success, 'Failed to send');
  }

function timeLeft() public view returns (uint256){
   if (block.timestamp >= deadline) {
          return 0;
      } else {
          return deadline - block.timestamp;
      }
}

  // Add a `timeLeft()` view function that returns the time left before the deadline for the frontend


  // Add the `receive()` special function that receives eth and calls stake()


}
