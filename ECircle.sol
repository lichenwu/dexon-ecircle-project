pragma solidity >=0.4.22 <0.6.0;

contract ECircle{
   //member
   address[] private members;
   mapping(address => string) private member_mail;
   mapping(address => uint8) private mapMember;

   // dex amount for every user
   mapping(address=>Wallet) private wallet;
   
   // exchange rate for each token to DEX
   mapping(string=>uint256) private exchangeRate;
    
   // token type
   string private TOKEN_TYPE="COB";
   
   // order related
   uint8 private ORDER_TYPE_LOAN=1;
   uint8 private ORDER_TYPE_LEND=2;
   uint256 private orderNoSeq = 0;
   uint256[] private ordersSeqArr;
   mapping(uint256 => Order) private orders;
   uint256[] private borrowOrderNo;
   uint256[] private supplyOrderNo;
   
   //
   uint256 private interestU=2;
   uint256 private borrowingInterestRate=3;
   uint256 private supplyInterestRate=1;

   struct Order {
      uint256 orderNo;
      uint8 orderType; //ORDER_TYPE_LOAN, ORDER_TYPE_LEND
      string token;
      uint256 amount;
      uint256 interest;
      address reqUser;
   }
   
   struct Wallet{
       uint256 dexAmount;
       uint256 tokenAmount;
   }
    
    constructor() public{
        exchangeRate[TOKEN_TYPE]=5;
        interestU=2;
        borrowingInterestRate=3;
        supplyInterestRate=1;
    }
    
    /*
    Register
    */
    function register(string memory email) public returns (bool){
        if(mapMember[msg.sender] == 0){
            mapMember[msg.sender] = 1;
            member_mail[msg.sender] = email;
            members.push(msg.sender);
            return true;
        }else{
            // already registered
            return false;
        }
        
    }
    
    /*
    deposit DEX
    */
    function deposit(uint256 amount) public returns(uint256){
        wallet[msg.sender].dexAmount = wallet[msg.sender].dexAmount + amount;
        return wallet[msg.sender].dexAmount;
    }
    
    /*
    token amount 
    */
    function dexToToken(uint256 dexAmount, string memory tokenType) public view returns (uint256){
        uint256 tokenAmount = dexAmount * exchangeRate[tokenType];
        return tokenAmount;
    }
    
    function tokenToDex(uint256 tokenAmount, string memory tokenType) public view returns(uint256){
        uint256 dexAmount = tokenAmount / exchangeRate[tokenType];
        return dexAmount;
    }
    
    /* request */
    function borrow(string memory tokenType, uint256 amount, uint256 interest) 
        public
        isValidateUser
        validateDexAmount
        returns (uint256){

        return genOrder(amount, tokenType, interest, ORDER_TYPE_LOAN);
    }
    
    function supply(string memory tokenType, uint256 amount, uint256 interest) 
        public
        isValidateUser
        validateDexAmount
        returns (uint256){
        return genOrder(amount, tokenType, interest, ORDER_TYPE_LEND);
    }
    
    function genOrder(uint256 amount, string memory tokenType, uint256 interest, uint8 orderType) 
        private returns (uint256){
        
        Order memory one;
        one.orderNo=genOrderNo();
        one.orderType=orderType;
        one.token = tokenType;
        one.amount = amount;
        one.interest = interest;
        one.reqUser = msg.sender;

        ordersSeqArr.push(one.orderNo);
        orders[one.orderNo]=one;

        return orders[one.orderNo].orderNo;
    }
    
    function getOrder(uint256 orderNo) 
        public view returns(uint256,uint8, string memory, uint256,uint256,address){
        
        Order memory one = orders[orderNo];
      
        return (one.orderNo, one.orderType, one.token, one.amount, one.interest, one.reqUser);
    }
    
    // function getCurrentInterest() view private returns (uint256){
    //     return 1;
    // }
    
    function genOrderNo()  private returns(uint256){
        return ++orderNoSeq;
    }
     
    modifier validateDexAmount{
        uint256 amount = wallet[msg.sender].dexAmount;
        require(amount>0, "Your DEX amount is 0, please deposit.");
        _;
    }
    
    modifier isValidateUser {
        uint8 userAddr = mapMember[msg.sender];
        require(userAddr>0, "You haven't registered yet, please register first.");
        _;
    }
}