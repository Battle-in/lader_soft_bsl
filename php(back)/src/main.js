// eslint-disable-next-line no-unused-vars
import Vue from 'vue'
import App from './App.vue'
import './assets/style/null.scss'
import './assets/style/index.scss' 
import router from './router'
// eslint-disable-next-line no-unused-vars
import axios from 'axios';


Vue.config.productionTip = false

new Vue({
  router ,
  render: h => h(App),
}).$mount('#app')
