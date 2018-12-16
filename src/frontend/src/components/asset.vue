<template>
  <div>
    <el-row class="header">
      <el-col :span="4"><div class="grid-content">Token Name</div></el-col>
      <el-col :span="4"><div class="grid-content">Price</div></el-col>
      <el-col :span="4"><div class="grid-content">Rate(APR)</div></el-col>
      <el-col :span="4"><div class="grid-content">Balance</div></el-col>
      <el-col :span="4"><div class="grid-content">Operation</div></el-col>
    </el-row>
    <el-row v-for="(asset, index) in assets" :key="index">
      <el-col :span="4"><div class="grid-content">{{ asset.tokenFullName }}</div></el-col>
      <el-col :span="4"><div class="grid-content">{{ asset.price }} DEX</div></el-col>
      <el-col :span="4"><div class="grid-content">{{ asset.rate }}%</div></el-col>
      <el-col :span="4"><div class="grid-content">{{ asset.balance }}</div></el-col>
      <el-col :span="7">
        <div class="sub-menu">
          <el-button type="info" @click="clickSupply">Supply</el-button>
          <el-button type="success" @click="clickBorrow">Borrow</el-button>
          <el-button type="danger" @click="balance">Balance</el-button>
        </div>
      </el-col>
    </el-row>
  </div>
</template>
<script>
import { mapState, mapActions } from 'vuex'

export default {
  data() {
    return {
    }
  },
	computed: {
		...mapState('accountStore', ['assets']),
	},
  methods: {
    ...mapActions('accountStore', ['runSupply']),
    clickSupply() {
      this.$prompt('Please input how many DEX to supply', 'Supply', {
        confirmButtonText: 'OK',
        cancelButtonText: 'Cancel',
        inputPattern: /^\d*\.*\d*$/,
        inputErrorMessage: 'Invalid Number'
      }).then(({ value }) => {

        this.runSupply(value);

        this.$message({
          type: 'success',
          message: `Your supply ${value} DEX`,
          showClose: true,
        });
      }).catch(() => {

      });
    },
    clickBorrow() {
      this.$prompt('Please input how many DEX to borrow', 'Borrow', {
        confirmButtonText: 'OK',
        cancelButtonText: 'Cancel',
        inputPattern: /^\d*\.*\d*$/,
        inputErrorMessage: 'Invalid Number'
      }).then(({ value }) => {
        this.$message({
          type: 'success',
          message: `Your borrow ${value} DEX`,
          showClose: true,
        });
      }).catch(() => {

      });
    },
    balance() {
      this.$confirm('This will balance all of this token. Continue?', 'Balance', {
        confirmButtonText: 'OK',
        cancelButtonText: 'Cancel',
        type: 'warning'
      }).then(() => {
        this.$message({
          type: 'success',
          message: 'Balance completed'
        });
      }).catch(() => {
        this.$message({
          type: 'info',
          message: 'Balance canceled'
        });
      });
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

