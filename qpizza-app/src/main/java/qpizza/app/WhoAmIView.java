package qpizza.app;

import jakarta.inject.Inject;

import org.eclipse.microprofile.rest.client.inject.RestClient;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.html.Paragraph;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.router.Route;

@Route("user/whoami")
public class WhoAmIView extends VerticalLayout {

    @Inject @RestClient
    WhoAmIClient client;

    public WhoAmIView() {
        var button = new Button("Who Am I?", e -> invokeWhoAmI());
        addClassName("centered-content");
    }

    private void invokeWhoAmI() {
        add(new Paragraph("Let's check..."));
        var info = client.getWhoAmI();
        var isAnonymous = info.get("isAnonymous");
        var name = info.get("name");
        var msg = "anonymous ? " + isAnonymous + " ";
        add(new Paragraph(msg));
    }
}
