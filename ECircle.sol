pragma solidity ^0.4.25;

contract ECircle{
    
    //member
    address[] private members;
    mapping(address => string) private member_mail;
    mapping(address => uint8) private mapMember;
    
    constructor() public{
        
    }
    
    /*
    Register
    */
    function register(string email) public returns (string){
        if(mapMember[msg.sender] == 0){
            mapMember[msg.sender] = 1;
            member_mail[msg.sender] = email;
            members.push(msg.sender);
        }else{
            // already registered
            return "You have registered";
        }
        
    }
    
}