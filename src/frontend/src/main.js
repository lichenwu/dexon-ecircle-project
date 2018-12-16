import Vue from 'vue'
import App from './App.vue'
import ElementUI from 'element-ui';
import './element-variables.scss';
import { store } from './store/'
import router from './router'
import handler from './util/getWeb3';

Vue.use(ElementUI);

Vue.config.productionTip = false

handler.setStore(store);

new Vue({
  render: h => h(App),
  store,
  router,
}).$mount('#app')
