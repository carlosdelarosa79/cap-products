//ACA ESTAMOS LEVANTANDO UN SERVIDOR POR MEDIO DEL /ALIVE PONEOS ESO AL FINAL DE LA URL QUE SE LEVANTA Y TENEMOS NUESTRO SERVIDOR 

const cds = require("@sap/cds");
const cors = require("cors");

cds.on("bootstrap", (app) =>{
    app.use(cors());
    app.get("/alive", (_,res) =>{
        res.status(200).send("servidor esta vivo");
    });
});

module.exports = cds.server;