package qpizza.api;

import java.util.Map;

import io.quarkus.security.Authenticated;
import io.quarkus.security.identity.SecurityIdentity;
import jakarta.inject.Inject;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

@Path("user")
public class WhoAmIResource {
    @Inject
    SecurityIdentity id;

    @Path("whoami")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    @Authenticated
    public Map<String, String> getWhoAmI() {
        return getUserInfo();
    }

    @Path("whoami_pub")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Map<String, String> getWhoAmIPub() {
        return getUserInfo();
    }

    private Map<String, String> getUserInfo() {
        var name = "";
        if (! id.isAnonymous()){
            name = id.getPrincipal().getName();
        }
        var result = Map.of(
            "isAnonymous", ""+id.isAnonymous(),
            "name", name
        );
        return result;
    }   
}