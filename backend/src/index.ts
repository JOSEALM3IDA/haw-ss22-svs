import express from 'express';
import { TLSSocket }  from 'tls'

const app = express();

// declare a route with a response
app.get('/secure', (req, res) => {
    const cert = ((req.socket) as TLSSocket).getPeerCertificate();
    res.send("Hello " + cert.subject.CN + "!");
});

// start the server
app.listen(8081, () => {
    console.log(`server running on port 8081`);
});