package org.hspconsortium.platform.config;

import ca.uhn.fhir.jpa.dao.DaoConfig;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;

/**
 * Created by cmbylund on 11/6/15.
 */
@Configuration
@ImportResource("classpath:hapi-fhir-server-resourceproviders-dstu2.xml")
public class ResourceProfiderConfig {

    @Bean(name = "myDaoConfig")
    public DaoConfig myDaoConfig() {
        return new DaoConfig();
    }

}
