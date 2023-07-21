// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Erc20Token {

    string public TkName;
    string public TkSymbol;
    address public TkOwner;
    uint256 public TotalSupply;


    // mapping function 
    mapping(address => uint)public balanceOf;
   

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Burn(address indexed from, uint value);
    event Mint(address indexed to, uint value);

    constructor(string memory _EnterTkname, string memory _EnterTksymbol) {
        TkName = _EnterTkname;
        TkSymbol = _EnterTksymbol;
        TkOwner = msg.sender;
        TotalSupply = 0;
    }


    function mint(address to, uint value) public  {
    
        require(msg.sender == TkOwner, "Only Contract Owner can mint Tokens");
        require(value > 0, "Please Enter a valid Amount");


        TotalSupply += value;
        balanceOf[to] += value;

        emit Mint(to, value);
        
    }

    function burn(uint256 value) public  {

        require(balanceOf[msg.sender] >= value, "YOU CAN ONLY BURN AMOUNT LESS OR EQUAL TO CURRENT BALANCE");

        TotalSupply -= value;
        balanceOf[msg.sender] -= value;

        emit Burn(msg.sender, value);
       
    }

    function transfer(address to, uint value) external returns (bool) {
        
        require(balanceOf[msg.sender] >= value, "YOUR ARE TRANSFERING MORE THAN CURRENT BALANCE");

        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;

        emit Transfer(msg.sender, to, value);
        return true;
    }
}
