<template>
  <div class="balance">
    <el-row type="flex" class="row-bg">
      <el-col :span="6"><div class="grid-content bg-purple">
        <h4>Supply Balance</h4>
        <h3>0 DEX</h3>
      </div></el-col>
      <el-col :span="6"><div class="grid-content bg-purple-light">
        <h4>Borrow Balance</h4>
        <h3>0 DEX</h3>
      </div></el-col>
      <el-col :span="6"><div class="grid-content bg-purple">
        <h4>Availablable to borrow</h4>
        <h3>0 DEX</h3>
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
}
</style>

