// ACA VAMOS A EXPONER OTRO SERVICIO !!!

using {sapbackend as external} from './external/sapbackend';

define service SAPBackendExit {
    @cds.persistence: {
        table,
        skip: false
    }
      @cds.autoexpose
     entity Incidents as select from external.IncidentsSet;
    
}

//aca exponemos los servicios CAP pero como protocolo REST
 @protocol: 'rest'
 service Restservice {
     entity Incidents as projection on SAPBackendExit.Incidents;
}


