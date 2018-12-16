<template>
  <div class="menu">
    <el-row :gutter="20">
      <el-col :span="4">
        <h1>ECircle</h1>
      </el-col>
      <el-col :span="12">
        <div class="sub-menu">
          <el-button type="primary" @click="clickDeposit">Deposit</el-button>
          <el-button type="primary" @click="clickWithdraw">Withdraw</el-button>
        </div>
      </el-col>
      <el-col :span="4">
        <el-input
          class="contractAddress"
          placeholder="Please input contract address"
          @input="contractAddress => setContractAddress({contractAddress})"
          :value="contractAddress"
        ></el-input>
      </el-col>
    </el-row>
  </div>

</template>

<script>
import { mapState, mapActions } from 'vuex'

export default {
  data() {
    return {
    };
  },
	computed: {
		...mapState('accountStore', ['contractAddress']),
	},
  methods: {
    ...mapActions('accountStore', ['setContractAddress', 'runDeposit']),
    clickDeposit() {
      this.$prompt('Please input how many DEX to deposit', 'Deposit', {
        confirmButtonText: 'OK',
        cancelButtonText: 'Cancel',
        inputPattern: /^\d*\.*\d*$/,
        inputErrorMessage: 'Invalid Number'
      }).then(async ({ value }) => {

        this.runDeposit(value)

        this.$message({
          type: 'success',
          message: `Your deposit ${value} DEX`,
          showClose: true,
        });
      }).catch(() => {

      });
    },
    clickWithdraw() {
      this.$prompt('Please input how many DEX to withdraw', 'Withdraw', {
        confirmButtonText: 'OK',
        cancelButtonText: 'Cancel',
        inputPattern: /^\d*\.*\d*$/,
        inputErrorMessage: 'Invalid Number'
      }).then(({ value }) => {
        this.$message({
          type: 'success',
          message: `Your withdraw ${value} DEX`,
          showClose: true,
        });
      }).catch(() => {

      });
    }
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
