pragma solidity >=0.4.23 <0.6.0;
contract Trade {
    address owner;
    mapping(address => uint256) public countIdOder;
    mapping(address =>  uint[]) public listBuy;
    mapping(address =>  uint[]) public listSell;
    mapping(address =>  mapping(uint256 => Order)) public BuyOder;
    mapping(address => uint256) public countTransaction;
    mapping(address =>  uint[]) public listTransaction;
    mapping(address =>  mapping(uint256 => Transaction)) public Transactions;
    constructor () public {
		owner = msg.sender;
	}

	struct Order {
		uint256 tokens;
		uint256 orderType; // 0 Buy - 1 Sell
		address trade;
	 	uint256 price;
	 	bool	isActive;
	}
	struct Transaction {
		uint256 tokens;
	}

	function buy(address addr ,address trader , uint256 token , uint256 price) public  returns(bool sucess){
		// uint256 count =0;
		// for(uint256 idx = 0 ; idx < listSell[addr].length ; idx++){
		// 	uint256 id = listSell[addr][idx];
		// 	Order memory oder = BuyOder[addr][id];
		// 	if(oder.isActive == true && oder.orderType == 1 && oder.price <= price){
		// 		count = count + id;
		// 	}
		// }
		// return count;
		createOder(addr,trader ,token , price ,0);
		sucess = true;
	}

	function sell(address addr ,address trader ,  uint256 token , uint256 price) public  returns(bool sucess){
		// uint256 count =0;
		// for(uint256 idx = 0 ; idx < listBuy[addr].length ; idx++){
		// 	uint256 id = listBuy[addr][idx];
		// 	Order memory oder = BuyOder[addr][id];
		// 	if(oder.isActive == true && oder.orderType == 0 && oder.price >= price){
		// 		count = count + id;
		// 	}
		// }
		// return count;
		createOder(addr, trader , token , price ,1);
		sucess = true;
	}

	function createOder(address addr, address trader  , uint256 token , uint256 price , uint256 orderType) private {
		countIdOder[addr] = countIdOder[addr]  + 1;

		BuyOder[addr][countIdOder[addr]].tokens = token;
		BuyOder[addr][countIdOder[addr]].orderType = orderType;
		BuyOder[addr][countIdOder[addr]].trade = addr;
		BuyOder[addr][countIdOder[addr]].price = price;
		BuyOder[addr][countIdOder[addr]].isActive = true;

		if(orderType ==0){
			listBuy[addr].push(countIdOder[addr]);
		}else{
			listSell[addr].push(countIdOder[addr]);
		}
	}

	function matchingBuy(address addr ,uint256 idOder,  uint256 token) public  returns(uint256 tokenSuplly){
		Order storage oder = BuyOder[addr][idOder];
		uint256 tokenSell;
		if(oder.tokens < token){
			tokenSell = oder.tokens;
		}else{
			tokenSell = token;
		}

		oder.tokens = oder.tokens - tokenSell;
		if(oder.tokens == 0){
			oder.isActive = false;
		}

		tokenSuplly = token - tokenSell;
	}

	function matchingSell(address addr ,uint256 idOder,  uint256 token) public  returns(uint256 tokenSuplly){
		Order storage oder = BuyOder[addr][idOder];
		uint256 tokenSell;
		if(oder.tokens < token){
			tokenSell = oder.tokens;
		}else{
			tokenSell = token;
		}

		oder.tokens = oder.tokens - tokenSell;
		if(oder.tokens == 0){
			oder.isActive = false;
		}

		tokenSuplly = token - tokenSell;
	}

}