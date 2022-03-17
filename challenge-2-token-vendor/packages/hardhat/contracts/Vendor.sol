pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {

  event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);

  YourToken public yourToken;

  constructor(address tokenAddress) {
    yourToken = YourToken(tokenAddress);
  }

  uint256 public constant tokensPerEth = 100;

  // ToDo: create a payable buyTokens() function:
  function buyTokens() public payable{
    yourToken.transfer(msg.sender, msg.value * tokensPerEth);
    emit BuyTokens(msg.sender, msg.value, msg.value * tokensPerEth);
  }

  // ToDo: create a withdraw() function that lets the owner withdraw ETH
  function withdraw(uint256 _amt) public onlyOwner {
    yourToken.transfer(msg.sender, _amt);
  }

  // ToDo: create a sellTokens() function:

}
