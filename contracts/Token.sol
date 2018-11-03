pragma solidity ^0.4.24;

contract ERC20 {
    // Public variables of the token
    string public constant name = "Your Token Name";
    string public constant symbol = "YTN";

    // Creates an array with all balances
    mapping (address => uint256) public balanceOf;

    // Holds the total supply of our token
    uint256 public totalSupply = 1000;

    // The owner of the contract
    address owner; 

    // Generates a public event on the blockchain that will notify clients
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    // The constructor is called at contract creation and only once
    constructor() public {
        // The creator of the contract is the owner
        owner = msg.sender;
        // Add the total supply to the owner of the contract
        balanceOf[msg.sender] = totalSupply;
    }

    // Send coins
    function transfer(address _to, uint256 _value) public returns (bool success) {
        // Prevent transfer to 0x0 address
        require(_to != 0x0);
        // Check if sender has sufficient funds
        require(balanceOf[msg.sender] >= _value);
        // Save this for an assertion in the future
        uint256 previousBalances = balanceOf[msg.sender] + balanceOf[_to];
        // Subtract from the sender
        balanceOf[msg.sender] -= _value;
        // Add the same to the recipient
        balanceOf[_to] += _value;
        // Emit the event about transferred value
        emit Transfer(msg.sender, _to, _value);
        // Assert that the total involved amount stayed the same
        assert(balanceOf[msg.sender] + balanceOf[_to] == previousBalances);
        return true;
    }

    // Raise the total supply
    function raiseTotalSupply(uint256 _amount) public {
        // Authorization check
        require(msg.sender == owner, "Unauthorized");
        // Check for overflows
        require(totalSupply + _amount >= totalSupply, "Overflow detected");
        // Check if amount is not negative
        require(_amount > 0, "Total supply can only be raised");
        // Add the amount to the total supply
        totalSupply += _amount;
        // Add the amount to the balance of the owner
        balanceOf[owner] += _amount;
    }

    // Transfer the ownership of this token
    function transferOwnership(address _newOwner) public {
        // Authorization check
        require(msg.sender == owner, "Unauthorized");
        // Replace the old owner with the new owner
        owner = _newOwner;
    }
}