<template>
 	<TradeView />
</template>

<script>
import TradeView from './../../view/Trade' 
import { mapGetters, mapActions } from 'vuex';
import Trade from './../../js/Trade.js'
export default {
  computed: {
        ...mapGetters([
          'listGame',
          'idActive'
        ])
  },
  components:{
    TradeView
  },
  data () {
    return {
        
    }
  },
  mounted(){
     this.init();
  },
  methods:{
  	...mapActions([
          'SET_ID_ACTIVE',
          'SET_GAME_LIST_SHOW',
          'SET_ZOOM_LIST_SHOW',
          'SET_TOKEN'
    ]),
    init(){
    	 
    },
  }
}
</script>

<style>

</style>
