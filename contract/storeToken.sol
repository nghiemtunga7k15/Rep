pragma solidity ^0.4.25;
contract TokenInterface {
	function isTokenContract()  external pure returns(bool);
	function allowance(address tokenOwner, address spender) external pure returns (uint remaining);
	function approve(address spender, uint tokens) external returns (bool success);
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
}	