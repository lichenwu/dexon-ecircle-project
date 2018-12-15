<template>
  <el-container>
    <el-header>
      <Menu></Menu>
    </el-header>
    <el-main>

    </el-main>
  </el-container>
</template>

<script>
import Menu from './menu.vue';

export default {
  name: 'HelloWorld',
  components: {
    Menu,
  },
  props: {
    msg: String
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
