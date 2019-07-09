const Dice = {
  state: {
    listGame:  [
    	{nameToken:'ETH',id:0,change:-1.78,exchange:0.09,addToken:'TL9kS9Jzm35NZcb7vL1eEEHYBrsvmckJe3',addressStoreToken:'TGWkcBbngJvaSSXQEeU2QswFKYerbLRu5x'},
    	{nameToken:'BTC',id:1,change:1,exchange:0.008,addToken:'TGWkcBbngJvaSSXQEeU2QswFKYerbLRu5x',addressStoreToken:'TGWkcBbngJvaSSXQEeU2QswFKYerbLRu5x'},
    ],
    idActive:0,
    listZoom:[],
    listBuy:[],
    tokenUser:0,
    listBuyToken:[],
    listSellToken:[],
    orderHistory:[],
  },
  mutations: {
    SET_ID: ( state, idActive )                            => state.idActive          =  idActive,
    SET_GAME_LIST: ( state, listGame )                     => state.listGame          =  listGame,
    SET_ZOOM_LIST: ( state, listZoom )                     => state.listZoom          =  listZoom,
    SET_BUY_LIST: ( state, listBuy )                     => state.listBuy          =  listBuy,
    SET_TOKEN_USER: ( state, tokenUser )                     => state.tokenUser          =  tokenUser,
    SET_LIST_BUY_TOKEN: ( state, listBuyToken )                     => state.listBuyToken          =  listBuyToken,
    SET_LIST_SELL_TOKEN: ( state, listSellToken )                     => state.listSellToken          =  listSellToken,
    SET_LIST_OEDER_HISTORY: ( state, orderHistory )                     => state.orderHistory          =  orderHistory,
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
    Set_List_Buy_Token({ commit }, listBuyToken) {
      commit('SET_LIST_BUY_TOKEN', listBuyToken);
    },
    Set_List_Sell_Token({ commit }, listSellToken) {
      commit('SET_LIST_SELL_TOKEN', listSellToken);
    },
    Set_List_History({ commit }, orderHistory) {
      commit('SET_LIST_OEDER_HISTORY', orderHistory);
    },
  }
}

export default Dice
