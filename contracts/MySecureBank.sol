pragma solidity ^0.4.24;

contract MySecureBank {
    // The key is of type address (storing the client’s address)
    // The value is of type uint256 (storing the client’s balance) 
    mapping(address => uint256) private balances;

    // The owner of the bank
    address owner;

    constructor() public {
        owner = msg.sender; // The current owner is your own account.
    }

    // Returns the balance of client with address "_address"
    function getBalance() view public returns (uint256) {
        return balances[msg.sender];
    }

    // Sets the balance of client with address "_address"
    function setBalance(uint256 _newBalance, address _address) public {
        require(msg.sender == owner, "Unauthorized");
        balances[_address] = _newBalance;
    }

    // Allows the current owner to transfer control of the contract to a new owner
    function transferOwnership(address _newOwner) public {
        require(msg.sender == owner, "Unauthorized");
        owner = _newOwner;
    }
}