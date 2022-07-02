import express from 'express';
import { TLSSocket }  from 'tls'

const app = express();

// declare a route with a response
app.get('/secure', (req, res) => {
    res.send(req.headers);
});

// start the server
app.listen(8081, () => {
    console.log(`server running on port 8081`);
});