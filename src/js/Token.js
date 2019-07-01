import TRONWEB from './tron-web.js'
const Token = {
	CONTRACT_ADDRESS:'TL9kS9Jzm35NZcb7vL1eEEHYBrsvmckJe3',
	CONTRACT :null,
	init(callback){
		let self = this;
	    if (typeof(window.tronWeb) === 'undefined') {
	        setTimeout(self.init, 1000);
	    } else {
	      tronWeb
	        .contract()
	        .at(self.CONTRACT_ADDRESS)
	        .then(response)
	        .catch(error);
	      function response(tronContract) {
	        self.CONTRACT = tronContract;
	        return callback(true);
	      } 
	      function error(e) { 
	        return callback(false); 
	      }
	    }
	},
	getTokens(callback){
		this.CONTRACT
		.balanceOf(TRONWEB.getAccount())
		.call()
		.then(response)
		.catch(error)
		function response(succes) {
			let data = {
				"balances" : succes.balance
			}
			return callback(null , data);
		}
		function error(e) {
			return callback(e, null);
		}
	},
}
export default Token;