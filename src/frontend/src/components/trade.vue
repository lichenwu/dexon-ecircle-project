<template>
  <div>
    <Balance></Balance>
    <Asset></Asset>
  </div>
</template>
<script>
import Asset from './asset.vue'
import Balance from './balance.vue'

export default {
  components: {
    Asset, Balance,
  },
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
