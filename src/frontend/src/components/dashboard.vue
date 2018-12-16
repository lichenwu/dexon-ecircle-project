<template>
  <div class="dashboard">
    <el-container>
      <el-header>
        <Menu></Menu>
      </el-header>
      <el-main>
        <Trade></Trade>
      </el-main>
    </el-container>
  </div>
</template>

<script>
import Menu from './menu.vue';
import Trade from './trade.vue';

export default {
  name: 'HelloWorld',
  components: {
    Trade, Menu,
  },
  props: {
    msg: String
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.dashboard {
  width: 1140px;
  margin: auto;
}
</style>
