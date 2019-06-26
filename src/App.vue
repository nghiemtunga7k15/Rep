<template>
  <div id="app">
      <Haeder />
        <router-view></router-view>
      <Footer />
  </div>
</template>

<script>
  import Haeder from './components/Layout/Header.vue'
  import Footer from './components/Layout/Footer.vue'
  import Main from './js/Main.js'
  import Token from './js/Token.js'
export default {
  components:{
    Haeder,
    Footer
  },
  mounted(){
    setTimeout(() => {
          this.init()
    }, 1000)
  },
  data () {
    return {
        
    }
  },
  methods:{
    init(){
      let self = this;
      this.setupContractMain();
      this.setupContractToken();
    },
    setupContractMain(){
      Main.init(is_init=>{ })
    },
    setupContractToken(){
      Token.init(is_init=>{ })
    }
  }
}
</script>

<style>

</style>
