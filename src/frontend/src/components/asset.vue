<template>
  <div>
    <el-row class="header">
      <el-col :span="4"><div class="grid-content">Token Full Name</div></el-col>
      <el-col :span="4"><div class="grid-content">Token Id</div></el-col>
      <el-col :span="4"><div class="grid-content">Rate(APR)</div></el-col>
      <el-col :span="4"><div class="grid-content">Balance</div></el-col>
      <el-col :span="4"><div class="grid-content">Operation</div></el-col>
    </el-row>
    <el-row v-for="(asset, index) in assets" :key="index">
      <el-col :span="4"><div class="grid-content">{{ asset.tokenFullName }}</div></el-col>
      <el-col :span="4"><div class="grid-content">{{ asset.tokenId }}</div></el-col>
      <el-col :span="4"><div class="grid-content">{{ asset.rate }}%</div></el-col>
      <el-col :span="4"><div class="grid-content">{{ asset.balance }}</div></el-col>
      <el-col :span="5">
        <div class="sub-menu">
          <el-button type="info">Supply</el-button>
          <el-button type="success">Borrow</el-button>
        </div>
      </el-col>
    </el-row>
  </div>
</template>
<script>

export default {
  data() {
    return {
      assets: [
        {
          tokenFullName: 'Cobinhood token',
          tokenId: 'COB',
          rate: 3.5,
          balance: 1050,
        },
        {
          tokenFullName: 'EOS token',
          tokenId: 'EOS',
          rate: 2.5,
          balance: -5,
        },
        {
          tokenFullName: 'Ethereum token',
          tokenId: 'Eth',
          rate: 7.8,
          balance: 20,
        },
      ],
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="scss" scoped>
.grid-content {
  text-align: left;
  padding: 15px;
}

.sub-menu {
  padding: 7.5px;
}

.el-row:nth-child(even) {background: #EEE}
.el-row:nth-child(odd) {background: #FFF}

.header {
  font-weight: bold;
}
</style>

