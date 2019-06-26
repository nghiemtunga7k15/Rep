pragma solidity >=0.4.23 <0.6.0;
contract TokenInterface {
	function isTokenContract()  external pure returns(bool);
	function allowance(address tokenOwner, address spender) external pure returns (uint remaining);
	function approve(address spender, uint tokens) external returns (bool success);
	function transferFrom(address from, address to, uint tokens) external returns (bool success);
	function transfer(address to, uint tokens) external returns (bool success);
}
contract StoreToken{
	address owner; 
	TokenInterface public tokenContract;
	constructor () public {
		owner = msg.sender;
	}

	modifier isOwner(){
		require(msg.sender == owner);
		_;
	}

	function isStoreTokenContract() public pure returns(bool){
		return true;
	}

	function setContractToken(address _addrToken) public isOwner {
		tokenContract  = TokenInterface(_addrToken);
		if(tokenContract.isTokenContract() == false) { revert(); }
	}

	function transferFrom(address from, address to, uint tokens) public returns (bool success){
		tokenContract.transferFrom(from , to , tokens );
		success = true;
	}

	function transfer(address to, uint tokens)  public returns (bool success){
		tokenContract.transfer(to , tokens);
		success = true;
	}

	function demo(uint256 num) public view returns(uint256){
		return num;
	} 
	
}	