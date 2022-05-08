// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract NBCoinERC20 {

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);

    string private constant name_ = "NB Coin";
    string private constant symbol_ = "NBN";
    uint8 private constant decimals_ = 18;

    address private owner;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    mapping(address => uint256) balances;

    mapping(address => mapping (address => uint256)) allowed;

    uint256 totalSupply_;

    constructor(uint256 total) {
      owner = msg.sender;
      totalSupply_ = total;
      balances[msg.sender] = totalSupply_;
    }

    // Getter Functions 

    // See the name of the token 

    function name() public view returns (string memory){
        return  name_;
    }

    // See the symbol of the token 
    function symbol() public view returns (string memory){
        return symbol_;
    }
    
    // See the decimals 
    function decimals() public view returns (uint) {
      return decimals_;
    }

    // See the total supply 
    function totalSupply() public view returns (uint256) {
      return totalSupply_;
    }

 
   // Get Balances and Allowed Addresses 

    // Get balance of a token owner
   function balanceOf(address tokenOwner) public view returns (uint256) {
       return balances[tokenOwner];
   }

   // Get the allowance assigned to a specific delegate/spender
   function allowance(address owner, address spender) public view returns (uint256){
       return allowed[owner][spender];
   }


    // Approval function to assign allowance to another address 

   function approve(address spender, uint256 amount) public returns(bool) {
       allowed[msg.sender][spender] = amount;
       emit Approval(msg.sender, spender, amount);
   }

   // Transfer and TransferFrom functions

   function transfer(address receiver, uint256 amount) public onlyOwner returns (bool) {
       require(amount <= balances[msg.sender]);
       balances[msg.sender] -= amount;
       balances[receiver] += amount;
       emit Transfer(msg.sender, receiver, amount);
   }

   // Transfer token from a different owner account that gives allowance to msg.sender

   function transferFrom(address owner, address buyer, uint256 amount) public onlyOwner returns (bool) {
       require(amount <= balances[owner]);
       require(amount <= allowed[owner][msg.sender]);

       balances[owner] -= amount;
       allowed[owner][msg.sender] -= amount;
       balances[buyer] += amount;
       emit Transfer(owner, buyer, amount);
       return true;
   }

   // Mint Function 
    
}