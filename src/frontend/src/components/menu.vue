<template>
  <div class="menu">
    <el-row :gutter="20">
      <el-col :span="4">
        <h1>ECircle</h1>
      </el-col>
      <el-col :span="12">
        <div class="sub-menu">
          <el-button type="primary">Deposit</el-button>
          <el-button type="primary">Withdraw</el-button>
        </div>
      </el-col>
      <el-col :span="4">
        <el-input
          class="contractAddress"
          placeholder="Please input contract address"
          v-model="contractAddress"></el-input>
      </el-col>
    </el-row>
  </div>

</template>

<script>
export default {
  data() {
    return {
      contractAddress: '',
    };
  },
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="scss" scoped>
.menu {
  .sub-menu {
    display: inline-block;
    padding: 15px;
  }

  .contractAddress {
    width: 300px;
    padding: 15px;
  }
}


</style>
