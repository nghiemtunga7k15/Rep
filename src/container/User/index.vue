<template>
 	<UserView />
</template>

<script>
import UserView from './../../view/User' 
import  Main from './../../js/Main.js' 
import { mapGetters, mapActions } from 'vuex';
export default {

  components:{
    UserView
  },
  mounted(){
  },
  computed: {
        ...mapGetters([
           
        ])
  },

  data () {
    return {
        
    }
  },
  methods:{
  }
}
</script>

<style>

</style>
