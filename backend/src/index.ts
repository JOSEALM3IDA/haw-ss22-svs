import express from 'express';

const app = express();

// declare a route with a response
app.get('/secure', (req, res) => {
    res.send(`Hello user ${req.get("x-forwarded-user")}!\nCert subject: ${req.get("x-forwarded-subject")}`);
});

// start the server
app.listen(8081, () => {
    console.log(`server running on port 8081`);
});