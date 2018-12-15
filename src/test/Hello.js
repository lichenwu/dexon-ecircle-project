const Hello = artifacts.require("Hello");

contract('Hello', function(accounts) {
  let HelloContract;
  let oldRandValue;

  it("should deploys Hello contract", async function() {
    HelloContract = await Hello.new();
  });

  it("should have 0 as default value", async function() {
    const number = await HelloContract.get();
    assert.equal(number.toString(), '0');
  });

  it("should update random number without error", async function() {
    await HelloContract.update();
  });

  it("should return generated random number", async function() {
    const number = await HelloContract.get();
    assert.notEqual(number.toString(), '0');
    oldRandValue = number;
  });

  it("should generate different random number", async function() {
    await HelloContract.update();
    const number = await HelloContract.get();
    assert.notEqual(number, oldRandValue);
  });
});
