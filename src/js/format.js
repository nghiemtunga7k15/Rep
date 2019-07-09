const moment = require('moment');

export default {
	forMatDate(value){
		var horse = moment.unix(value).format('HH:mm') 
		var date = moment.unix(value).format("MM-DD");
		return horse + ' ' +  date;
	}
}