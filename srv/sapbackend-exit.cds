// ACA VAMOS A EXPONER OTRO SERVICIO !!!

using {sapbackend as external} from './external/sapbackend';

define service SAPBackendExit {
    @cds.persistence: {
        table,
        skip: false
    }
    @cds.autoexpose
    // entity Incidents as select from external.IncidentsSet;


    //con esta forma de llamar a la entity Incidents me sale el error 502
    entity Incidents as projection on external.IncidentsSet
    
}



