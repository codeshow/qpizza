package qpizza.api;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

@Path("/menu")
public class MenuResource {
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Menu getMenu() {
        var menu = new Menu(){{
            title = "Ola QPizzas";
        }};
        return menu;
    }   
}
