# ForeverAward

ForeverAward is a smart contract & associated factory, that lets anybody create a form of recognition and acknowledgment in a bottom-up way.  The award is made permanent on a blockchain.

The idea is that any member of any organization or community could nominate anybody for any form of award.  Then, any number of other members of the community can endorse the nomination and award.  The more endorsements, the more weight the award carries. 

This repo is a fork of the forevermore project.  Read the motivation for forevermore [here](https://medium.com/@nicolezhu/why-we-committed-our-marriage-vows-to-the-blockchain-3b7c640b5927). 

## Demo

There is a demo of [Forevermore](https://forevermore.io), but the ForeverAward front-end isn't finished - yet, despite there actually being one award created with this code live on mainnet.

**To compile your own contracts:**
CD into Ethereum directory, then run: 

    $ node compile.js

**To deploy your own contracts:**

    // Never commit this file!
    
    const HDWalletProvider = require('truffle-hdwallet-provider');
    const Web3 = require('web3');
    const compiledFactory = require('./build/MarriageRegistry.json');
    const fs = require('fs-extra')
    
    const provider = new HDWalletProvider(
      // NEVER SHARE your keys!
      'YOUR OWN KEY FOR DEPLOYING FACTORY CONTRACT',
      'https://mainnet.infura.io/[YOUR ACCOUNT]'
    );
    
    const web3 = new Web3(provider);
    
    const deploy = async () => {
      console.log("Starting to deploy...");
      const accounts = await web3.eth.getAccounts();
    
      console.log("Attempting to deploy from account", accounts[0]);
    
      const result = await new web3.eth.Contract(JSON.parse(compiledFactory.interface))
        .deploy({ data: '0x' + compiledFactory.bytecode })
        .send({ from: accounts[0], gas: '5000000' });
    
      console.log(compiledFactory.interface);
      console.log('Contract deployed to', result.options.address);
    
    }
    deploy();

## Contributing

 1. Fork it the project
 2. Create your feature branch using issue #: `git checkout -b issue#-feature`
 3. Commit your changes: git commit -am 'Fix/Add/Change: commit msg'
 4. Push to the branch: `git push origin issue#-feature`
 5. Create a new Pull Request

See full list of outstanding [issues](https://github.com/jnmclarty/foreveraward/issues).

## License
MIT License
