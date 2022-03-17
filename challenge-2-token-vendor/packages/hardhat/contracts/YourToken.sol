pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// learn more: https://docs.openzeppelin.com/contracts/3.x/erc20

contract YourToken is ERC20 {
    address FRONTEND_ADDR = 0x6a04Ec7fAA54462ff7e8606Df03954B2094d2266;
    uint256 initSupply = 1000 * 10**18;
    constructor() ERC20("Gold", "GLD") {    
        //_mint( ~~~YOUR FRONTEND ADDRESS HERE~~~~ , 1000 * 10 ** 18);
        //0x6a04Ec7fAA54462ff7e8606Df03954B2094d2266
         
        _mint(msg.sender, initSupply);

    }
}
