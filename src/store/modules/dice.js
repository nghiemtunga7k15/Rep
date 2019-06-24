const Dice = {
  state: {
    listGame:  [
    	{nameToken:'ETH',id:0,change:-1.78,exchange:0.09,addressStoreToken:'TRkZ9FFAsQW2fZGhrthwUY4aAz5UZQ1TAc'},
    	{nameToken:'BTC',id:1,change:1,exchange:0.008,addressStoreToken:'TDJFzpUD1ZbKNP6c9YN7s7nQ3HGBPpJYJo'},
    ],
    idActive:0,
    listZoom:[],
    listBuy:[],
    tokenUser:0,
  },
  mutations: {
    SET_ID: ( state, idActive )                            => state.idActive          =  idActive,
    SET_GAME_LIST: ( state, listGame )                     => state.listGame          =  listGame,
    SET_ZOOM_LIST: ( state, listZoom )                     => state.listZoom          =  listZoom,
    SET_BUY_LIST: ( state, listBuy )                     => state.listBuy          =  listBuy,
    SET_TOKEN_USER: ( state, tokenUser )                     => state.tokenUser          =  tokenUser,
  },
  actions: {
 	  SET_ID_ACTIVE({ commit }, idActive) {
      commit('SET_ID', idActive);
    },
    SET_GAME_LIST_SHOW({ commit }, listGame) {
      commit('SET_GAME_LIST', listGame);
    },
    SET_ZOOM_LIST_SHOW({ commit }, listZoom) {
      commit('SET_ZOOM_LIST', listZoom);
    },
    SET_BUY_LIST_SHOW({ commit }, listBuy) {
      commit('SET_BUY_LIST', listBuy);
    },
    SET_TOKEN({ commit }, tokenUser) {
      commit('SET_TOKEN_USER', tokenUser);
    },
  }
}

export default Dice
