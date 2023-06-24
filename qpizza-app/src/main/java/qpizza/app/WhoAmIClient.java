package qpizza.app;

import java.util.Map;

import org.eclipse.microprofile.rest.client.inject.RegisterRestClient;

import io.quarkus.oidc.token.propagation.AccessToken;
import jakarta.ws.rs.GET;

@RegisterRestClient(configKey = "whoami")
@AccessToken
public interface WhoAmIClient {
    @GET
    public Map<String, String> getWhoAmI();
}
