package org.hspconsortium.platform.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;
import org.springframework.context.annotation.Profile;

/**
 * Created by cmbylund on 11/6/15.
 */
@Configuration
@Profile("mysql")
// TODO: move the contents of this file to code configuration
@ImportResource("classpath:context/fhir-service-database-config-mysql.xml")
public class DataSourceMysqlConfig {
}
