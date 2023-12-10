const cds = require("@sap/cds");
const req = require("express/lib/request");
const { Orders } = cds.entities("com.training");

module.exports = (srv) => {
    //********READ*******/
    srv.on("READ", "GetOrders", async (req) => {

        if (req.data.ClientEmail !== undefined) {
            return await SELECT.from`com.training.Orders`.where`ClientEmail = ${req.data.ClientEmail}`;
        }

        return await SELECT.from(Orders);
    });
    // aca pasamos a TRUE los parametros que vienen en el archivo o db como FALSE
    srv.after("READ", "GetOrders", (data) => {
        return data.map((order) => (order.Reviewed = true
        ));
    });

    //********CREATE*******/
    //realizamos una variable de nombre returnData, tenemos el async y await, ejecutamos la funcion con .run INSERT
    // tenemos una promesa con .then si se resuelve ejecuta si no nos envia el error y los mostramos en la consola tambn
    srv.on("CREATE", "CreateOrder", async (req) => {
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
};


