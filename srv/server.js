//ACA ESTAMOS LEVANTANDO UN SERVIDOR POR MEDIO DEL /ALIVE PONEOS ESO AL FINAL DE LA URL QUE SE LEVANTA Y TENEMOS NUESTRO SERVIDOR 

const cds = require("@sap/cds");
const cors = require("cors");
const adapterProxy = require("@sap/cds-odata-v2-adapter-proxy");

cds.on("bootstrap", (app) => {
    app.use(adapterProxy());
    app.use(cors());
    app.get("/alive", (_, res) => {
        res.status(200).send("servidor esta vivo");
    });
});

if (process.env.NODE_ENV !== 'production') {
    require("dotenv").config();
}

module.exports = cds.server;