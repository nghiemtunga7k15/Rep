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
  import Main from './js/main.js'
export default {
  components:{
    Haeder,
    Footer
  },
  mounted(){
    this.setupContract();
  },
  data () {
    return {
        
    }
  },
  methods:{
    setupContract(){
      Main.init(is_init=>{ })
    }
  }
}
</script>

<style>

</style>
