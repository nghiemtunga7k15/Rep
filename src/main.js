import Vue from 'vue'
import App from './App.vue'
import BootstrapVue from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

import VueI18n from 'vue-i18n'
import  router from './router'
import  store from './store'

Vue.use(BootstrapVue)
Vue.use(VueI18n)

const i18n = new VueI18n({
  locale: localStorage['lang'] || 'zh', // 设置语言  default language is english
  messages: {
    'en': require('./../lang/en.js'),
    '中国': require('./../lang/china.js'),
  }
})
new Vue({
  el: '#app',
  router,
  i18n,
  store,
  render: h => h(App)
})
