pragma solidity >=0.4.23 <0.6.0;


/*
* Transfer TRX Contract
* Author: P3T Team
* Website: https://p3t.network/tools/transfertrx
* Hide your sender with a Smart Contract
* No fee
*/

contract TransferTrx {
	event eventOnTransfer(address _transferPerson, address _receiverPerson, uint256 _trx);
	function () external payable {
	}

	function actionTranfer(address _receiver) public payable {
		tranfer(msg.sender,_receiver,msg.value);
	}
	function tranfer(address _transferPerson , address _receiverPerson, uint256 _trx) private {
		address payable _receiverPerson;
		if (_receiverPerson != address(0)) {
			// address receiver = _receiverPerson;
			_receiverPerson.transfer(_trx);
			emit eventOnTransfer(_transferPerson, _receiverPerson, _trx);
		}
		else {
			revert();
		}
	}
}