package org.hspconsortium.platform;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.web.SpringBootServletInitializer;

/**
 * Created by cmbylund on 11/10/15.
 */
@SpringBootApplication
public class HspServerFhirApp extends SpringBootServletInitializer {
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(HspServerFhirApp.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(HspServerFhirApp.class, args);
    }
}
