// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";


// //creating a simple erc20 token using openzeppelin library

// contract SampleToken is ERC20, Ownable {
//     constructor() ERC20("sampleToken", "ST") {
//         _mint(msg.sender,100000*10**18);
//     }

// }

//this is erc20 token from scratch
contract simpleToken {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    mapping (address=>uint256) public balanceOf;
    mapping(address=>mapping(address=>uint256)) public allowance;

    //constructor is the one time usage to create the name and supply
    constructor(string memory _name,string memory _symbol, uint256 _totalSupply, uint8 _decimals)
    {
        name=_name;//_name;
        symbol=_symbol;//_symbol;
        decimals=_decimals;//_decimals;
        totalSupply=_totalSupply;
        balanceOf[msg.sender]=_totalSupply * (10 ** decimals);
    }

    function transfer(address _to,  uint256 _value)public returns(bool success){
        require(balanceOf[msg.sender]>=_value);
        balanceOf[msg.sender]-=_value;
         balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return(true);

    }
     function transferFrom(address _from, address _to, uint256 _value) public returns (bool success)
    {
        require(allowance[_from][msg.sender] >= _value);
        require(balanceOf[_from] >= _value);
        allowance[_from][msg.sender] -= _value;
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(_from, _to, _value);
        return(true);
    }

    function approve(address _spender, uint256 _value) public returns (bool success)
    {
        allowance[msg.sender][_spender]=0;
        allowance[msg.sender][_spender]=_value;
        emit Approval(msg.sender, _spender, _value);
        return(true);
    }
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}