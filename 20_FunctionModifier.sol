// SPDX-License-Identifier:MIT

  pragma solidity ^0.8.17;

  contract FunctionModifier {

      address public owner;
      uint public tokenPerSecond;// 1 saniyede dağıtılacak token miktarı -> 100 token ödül dağıtılıyor
     
      constructor(){
          owner = msg.sender;
      }


      modifier onlyOwner(){
         require (owner == msg.sender,"You're not owner");
         _;  // function body placeholder ->yerini alır

      }

      // modifier -> tokenPerSecond pozitif bir syı olmalı bunu kontrol eden bir modifier yazın.

      modifier onlyPositiveNumber(){
          require(tokenPerSecond >0,"Number must be positive");
          _;
      }
    

      function changeTokenPerSecond (uint _i) public onlyOwner onlyPositiveNumber{
          // öyle bir require yazalım ve sadece owner çalıştırabilsin.
          
          tokenPerSecond =_i;
      }

      function example () public onlyOwner onlyPositiveNumber {

      }

      // fonksiyonun amacı owner değiştirmek, transferOwnership ->newOwner adres al ve bunu ownera set et
       function transferOwnership(address newOwner) public onlyOwner{
        //require(newOwner != address(0)); // 0x000000000000000000000000000000
        owner = newOwner;
       }


       bool public locked;

       modifier noReentrancy() {
           require(!locked,"No Reentrancy");
           locked =true;
           _;//withdraw placeholder
           locked = false;
           // events -> loglayabilirsin durumu
       }



     // noReentrancy

       mapping(address => uint256) public balances;

       // deposit önceden yapıldı yada yapılacaj deposit fonksitonumuz var.

       function deposit() public noReentrancy {
           // balance arttırıyor.
           // 100 ether deposit ediyor
       }

      function withdraw(uint amount) public noReentrancy {
          require(amount <= balances[msg.sender], "Insufficient Balance");
          (bool success,) = msg.sender.call{value: amount}("");// transfer
          require (success,"Transfer failed");
          balances[msg.sender] -amount;
       }

      // events_constructor ve inheritance


  }