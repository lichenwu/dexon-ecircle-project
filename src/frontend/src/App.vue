<template>
  <div id="app">
    <Dashboard />
  </div>
</template>

<script>
import Dashboard from './components/dashboard.vue'

export default {
  name: 'app',
  components: {
    Dashboard
  },
  mounted() {
    if(typeof window.dexon === 'undefined') {
      this.$alert('Please install Dekusan first!');
    } else {
      this.$notify({
        type: 'success',
        title: 'Dekusan status',
        message: 'Dekusan detected!',
      })
    }
  }
}
</script>
<style lang="scss">
body {
  padding: 0;
  margin: 0;
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
</style>

<style lang="scss" scoped>
#app {
  text-align: center;
  color: #354252;
}
</style>
