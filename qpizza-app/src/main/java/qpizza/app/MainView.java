package qpizza.app;

import jakarta.inject.Inject;

import org.eclipse.microprofile.rest.client.inject.RestClient;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.html.Paragraph;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.component.page.Page;
import com.vaadin.flow.router.Route;

@Route("")
public class MainView extends VerticalLayout {


    public MainView() {
        var button = new Button("Login with google :)", e -> gotoLogin());
        addClassName("centered-content");
        add(button);
    }

    private void gotoLogin() {
        getUI().ifPresent(ui -> ui.getPage().setLocation("/uer/whoami"));
    }
}
