<template>
  <div class="balance">
    <el-row type="flex" class="row-bg">
      <el-col :span="6"><div class="grid-content">
        <h4>Supply Balance</h4>
        <h2>0 DEX</h2>
      </div></el-col>
    </el-row>
  </div>
</template>
<script>

export default {

}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="scss" scoped>
.balance {
  text-align: left;

  .grid-content {
    border-radius: 8px;
    background-color: #eee;
    padding: 5px 20px;
  }
}
</style>

