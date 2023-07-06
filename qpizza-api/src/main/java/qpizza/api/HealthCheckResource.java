package qpizza.api;

import java.sql.SQLException;
import java.util.Map;

import javax.sql.DataSource;

import jakarta.inject.Inject;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

import qpizza.core.service.PizzaService;

@Path("/health")
public class HealthCheckResource {

    @Inject
    DataSource ds; 

    @Inject
    PizzaService pizzaSvc;

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Map<String, String> get() throws SQLException{
        var status = "ok";
        try( var conn = ds.getConnection()){
            if (conn.isValid(15)){
                status = "valid";
            }else {
                status = "invalid";
            }
        }
        var result = Map.of(
            "healthy", status,
            "pizza", pizzaSvc.getPizza()
            );
        return result;
    }
    
}
