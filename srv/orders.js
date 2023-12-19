const cds = require("@sap/cds");
const req = require("express/lib/request");
const { Orders } = cds.entities("com.training");

module.exports = (srv) => {
    //********READ*******/
    srv.on("READ", "Orders", async (req) => {

        if (req.data.ClientEmail !== undefined) {
            return await SELECT.from`com.training.Orders`.where`ClientEmail = ${req.data.ClientEmail}`;
        }

        return await SELECT.from(Orders);
    });
    // aca pasamos a TRUE los parametros que vienen en el archivo o db como FALSE
    srv.after("READ", "Orders", (data) => {
        return data.map((order) => (order.Reviewed = true
        ));
    });


    //********CREATE*******/
    //realizamos una variable de nombre returnData, tenemos el async y await, ejecutamos la funcion con .run INSERT
    // tenemos una promesa con .then si se resuelve ejecuta si no nos envia el error y los mostramos en la consola tambn
    srv.on("CREATE", "Orders", async (req) => {
        let returnData = await cds.transaction(req)
            .run(
                INSERT.into(Orders).entries({
                    ClientEmail: req.data.ClientEmail,
                    FirstName: req.data.FirstName,
                    LastName: req.data.LastName,
                    CreatedOn: req.data.CreatedOn,
                    Reviewed: req.data.Reviewed,
                    Approved: req.data.Approved,
                    Country_code: req.data.Country_code,
                    Status: req.data.Status
                })
            ).then((resolve, reject) => {
                console.log("Resolve", resolve);
                console.log("Reject", reject);

                if (typeof resolve !== "undefined") {
                    return req.data;
                } else {
                    req.error(409, "Record not Inserted");
                }
            })
            .catch((err) => {
                req.error(err.code, err.message);
            });
        return returnData;
    });
    //esta funcion se ejecuta antes de las demas , para asi poder cambiar la fecha a la actual
    srv.before("CREATE", "Orders", (req) => {
        req.data.CreatedOn = new Date().toISOString().slice(0, 10)
        return req;
    });


    //********UPDATE*******/
    srv.on("UPDATE", "Orders", async (req) => {
        let returnDate = await cds.transaction(req)
            .run([
                UPDATE(Orders, req.date.ClientEmail).set({
                    FirstName: req.date.FirstName,
                    LastName: req.data.LastName,

                })
            ])
            .then((resolve, reject) => {
                console.log("Resolve: ", resolve);
                console.log("Reject: ", reject);

                if (resolve[0] == 0) {
                    req.error(409, "Record not Found");
                }
            })
            .catch((err) => {
                console.log(err);
                req.error(err.code, err.message);
            });
        console.log("before End", returnDate);
        return returnDate;
    });


    //********DELETE*******/
    srv.on("DELETE", "Orders", async (req) => {
        let returnData = await cds
            .transaction(req)
            .run(DELETE.from(Orders).where({
                ClientEmail: req.data.ClientEmail,
            })
            )
            .then((resolve, reject) => {
                console.log("Resolve", resolve);
                console.log("reject", reject);

                if (resolve !== 1) {
                    req.error(409, "Record Not Found");
                }
            })
            .catch((err) => {
                console.log(err);
                req.error(err.code, err.message);
            });
        console.log("before end", returnData);
        return await returnData;
    });


    //********FUNCTION*******/
    srv.on("getClientTaxRate", async (req) => {
        try {
            const { clientEmail } = req.data;
            const db = srv.transaction(req);

            const results = await db.read(Orders, ["Country_code"]).where({ ClientEmail: clientEmail });

            if (results && results[0] && results[0].Country_code) {
                switch (results[0].Country_code) {
                    case 'ES':
                        return 21.5;
                    case 'UK':
                        return 24.6;
                    default:
                        break;
                }
            } else {
                // Manejar el caso donde no se encuentra el país o no hay resultados.
                console.error('No se encontró el país para el cliente:', clientEmail);
                return 0; // O el valor predeterminado que desees
            }
        } catch (error) {
            console.error('Error al obtener el país del cliente:', error);
            return 0; // O el valor predeterminado que desees
        }
    });

    //********ACTION*******/
    srv.on("cancelOrder", async (req) => {
        const { clientEmail } = req.data;
        const db = srv.transaction(req);
    
        const resultsRead = await db.read(Orders, ["FirstName", "LastName", "Approved"]).where({ ClientEmail: clientEmail });
    
        let returnOrder = {
            Status: "",
            message: ""
        };
    
        let resultsUpdate;  // Declarar resultsUpdate fuera del bloque if
    
        if (resultsRead[0].Approved === false) {
            resultsUpdate = await db.update(Orders).set({ Status: "C" }).where({ ClientEmail: clientEmail });
            returnOrder.Status = "succeeded";  // Corregir el typo en "succeeded"
            returnOrder.message = `The order placed by ${resultsRead[0].FirstName} ${resultsRead[0].LastName} was canceled`;
        } else {
            returnOrder.Status = "failed";
            returnOrder.message = `The order placed by ${resultsRead[0].FirstName} ${resultsRead[0].LastName} was NOT canceled`;
        }
    
        return returnOrder;

    });

};




