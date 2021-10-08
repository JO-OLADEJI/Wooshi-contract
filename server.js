const express = require('express');
const cors = require('cors');
const app = express();
const PORT = process.env.PORT || 3001;
const { mintNFT } = require('./scripts/mint-nft.js');


app.use(express.json());
app.use(cors());


// -> routes
app.get('/', (req, res) => {
  res.send('Wooshi NFT contract homepage');
});

app.post('/mint', async (req, res) => {
  const addr = req.body.addr;
  const hashLink = req.body.hashLink;

  const txHash = await mintNFT(
    addr,
    `https://gateway.pinata.cloud/ipfs/${hashLink}`
  );
  // return res.send({ success: true });
});


app.listen(PORT, () => {
  console.log(`Listening on port ${PORT}`);
});