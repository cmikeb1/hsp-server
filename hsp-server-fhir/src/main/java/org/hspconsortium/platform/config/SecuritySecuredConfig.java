package org.hspconsortium.platform.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;
import org.springframework.context.annotation.Profile;

/**
 * Created by cmbylund on 11/10/15.
 */
@Configuration
@Profile("secured")
// TODO: move the contents of this file to code configuration
@ImportResource("classpath:context/security-context-secured.xml")
public class SecuritySecuredConfig {
}
