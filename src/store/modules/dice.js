const Dice = {
  state: {
    listGame:  [
    	{nameToken:'ETH',id:0,change:-1.78,exchange:0.09},
    	{nameToken:'BTC',id:1,change:1,exchange:0.008},
    ],
    idActive:0,
    listZoom:[],
  },
  mutations: {
    SET_ID: ( state, idActive )                            => state.idActive          =  idActive,
    SET_GAME_LIST: ( state, listGame )                     => state.listGame          =  listGame,
    SET_ZOOM_LIST: ( state, listZoom )                     => state.listZoom          =  listZoom,
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
  }
}

export default Dice
