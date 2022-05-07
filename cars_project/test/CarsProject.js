async function shouldThrow(promise) {
    try {
        await promise;
       assert(true);
    }
    catch (err) {
        return;
    }
  assert(false, "The contract did not throw.");
  
  }
  
  module.exports = {
    shouldThrow,
  };
// helper functions above  




const CarsProject = artifacts.require("CarsProject");

const carNames = ["Ferrari 1", "Ford 2"];
// to do lesson 6 last part
contract("CarsProject",(accounts)=>{
    let [a,b]= accounts;
    let contractInstance;
    beforeEach(async ()=>{
        contractInstance =  await CarsProject.new();
    });
    it(" make a new car", async()=>{
        const result = await contractInstance.createRandCar(carNames[0], {from: a});
        assert.equal(result.receipt.status, true);
        assert.equal(result.logs[0].args.name,carNames[0]);
    })

    it("don't allow 2 rand cars", async () => {
        await contractInstance.createRandCar(carNames[0], {from: a});
        await shouldThrow(contractInstance.createRandCar(carNames[1], {from: a}));
    })

    // complete rest of functions test
})