import TRONWEB from './tron-web.js'
const Main = {
	CONTRACT_ADDRESS:'TDJFzpUD1ZbKNP6c9YN7s7nQ3HGBPpJYJo',
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
	getCountZom(address,callback){
		this.CONTRACT
		.getCountZom(address)
		.call()
		.then(response)
		.catch(error)
		function response(succes) {
			return callback(null , succes);
		}
		function error(e) {
			return callback(e, null);
		}
	},
	getZoomPlay(address,id,callback){
		this.CONTRACT
		.RoomPlay(address,id)
			.call()
			.then(response)
			.catch(error)
		function response(succes) {
			return callback(null , succes);
		}
		function error(e) {
			return callback(e, null);
		}
	},
	getcountRequest(address ,callback){
		this.CONTRACT
			.countRequest(address)
			.call()
			.then(response)
			.catch(error)
		function response(succes) {
			return callback(null , succes);
		}
		function error(e) {
			return callback(e, null);
		}	
	},
	getListRequest(address , id , callback){
		this.CONTRACT
			.listRequest(address , id)
			.call()
			.then(response)
			.catch(error)
		function response(succes) {
			return callback(null , succes);
		}
		function error(e) {
			return callback(e, null);
		}
	},
	changeToken(addressToken,addressBuyer , tokens){
		this.CONTRACT.changeToken(addressToken,addressBuyer,tokens).send()
	}
}
export default Main;