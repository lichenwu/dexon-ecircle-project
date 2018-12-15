pragma solidity >=0.4.22 <0.6.0;

contract Rand{
   uint8 private ORDER_TYPE_LOAN=1;
   uint8 private ORDER_TYPE_LEND=2;
   
   order[ ] private orders;
   uint256 private current_interest;
   uint256 private orderNoSeq = 0;

   struct order {
      uint256 orderNo;
      uint8 orderType;
      
      uint256 amount;
      //uint256 interest;
      uint256 round;
      uint256 borrowingTime;
   }

    
    function postLoan(uint256 amount, uint256 borrowingTime, uint256 round) public returns (bool){
        order memory one;
        one.orderNo=genOrderNo();
        one.orderType=ORDER_TYPE_LOAN;
        one.amount = amount;
        one.round = round;
        one.borrowingTime = borrowingTime;
        orders.push(one);
    }
    
    // function getCurrentInterest() view private returns (uint256){
    //     return 1;
    // }
    
    function genOrderNo()  private returns(uint256){
        return orderNoSeq++;
    }
    //The public testnet endpoint is available at: https://api-testnet.dexscan.org/v1/network/rpc
}