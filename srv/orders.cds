using com.training as training from '../db/training';

service ManageOrders {

    type cancelOrderReturn {
        Status  : String enum {
            suceeded;
            failed
        };
        message : String
    };


    function getClientTaxRate(clientEmail : String) returns Decimal(4, 2);
    action   cancelOrder(clientEmail : String(65))  returns cancelOrderReturn;


    //aca fucionamos lo que son la FUNCTION Y ACTION 
    // entity Orders as projection on training.Orders actions {
    //                      function getClientTaxRate(clientEmail : String) returns Decimal(4, 2);
    //                      action   cancelOrder(clientEmail : String(65))  returns cancelOrderReturn;
    //                  }
}
