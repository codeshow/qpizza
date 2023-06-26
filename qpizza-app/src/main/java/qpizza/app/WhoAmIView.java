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
        add(button);
    }

    private void invokeWhoAmI() {
        add(new Paragraph("Let's check, sending..."));
        try {
            var info = client.getWhoAmI();
            add(new Paragraph("received!"));
            var isAnonymous = info.get("isAnonymous");
            var name = info.get("name");
            var msg = "anonymous ? " + isAnonymous + " " + name;
            add(new Paragraph(msg));
            
        } catch (Exception ex){
            ex.printStackTrace();
            add(new Paragraph("Ooops"));
        }
        add(new Paragraph("done"));
        
    }
}
