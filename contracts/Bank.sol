// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

 contract Bank {
    
    struct Account{
      address  owner;
      uint balance;
    }

    // Account public Balance;
    // Account[] public  Owners;
    // address[] public accounts;
        
    mapping(address => Account) public accounts;
    mapping (address => bool) Registered;

    modifier isRegistered(){
        require(Registered[msg.sender],"Please kindly go and register first");
        _;
    }


    function register() external{
        require(!Registered[msg.sender] , "You have been registered");
                if(!Registered[msg.sender]){
            Registered[msg.sender] = true;
        accounts[msg.sender] = Account(msg.sender, 0);
           

        }
        
    }
    function deposit() external payable isRegistered{
        require(msg.value > 0 , "please deposit something");
        accounts[msg.sender].balance += msg.value;
    }

    function withdraw(uint _amount) external  payable isRegistered{
        require(accounts[msg.sender].balance >= _amount, "Insufficient balance");
         accounts[msg.sender].balance -= _amount;
         payable(msg.sender).transfer(_amount);
    }


    function transfer(address _reciepent, uint _amount) external isRegistered{
        require(Registered[_reciepent],"The reciever is not yet registered");
        require(accounts[msg.sender].balance >= _amount, "Insufficient balance");
        accounts[msg.sender].balance -= _amount;
        accounts[_reciepent].balance += _amount;
    }
    
    function checkBalance() external  isRegistered view returns(uint){
        return  accounts[msg.sender].balance;
    }
    
 }