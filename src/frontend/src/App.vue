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
  }
}
</script>
<style lang="scss">
body {
  padding: 0;
  margin: 0;
}
</style>

<style lang="scss" scoped>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #354252;
}
</style>
