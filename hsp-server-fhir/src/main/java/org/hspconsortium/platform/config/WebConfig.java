package org.hspconsortium.platform.config;

import org.ebaysf.web.cors.CORSFilter;
import org.hspconsortium.platform.fhir.FHIRService;
import org.hspconsortium.platform.filter.CsrfHeaderFilter;
import org.springframework.boot.context.embedded.FilterRegistrationBean;
import org.springframework.boot.context.embedded.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;
import org.springframework.web.filter.DelegatingFilterProxy;
import org.springframework.web.servlet.DispatcherServlet;

/**
 * Created by cmbylund on 11/10/15.
 */
@Configuration
@ImportResource({"classpath:context/fhir-service-config.xml"})
public class WebConfig {
    @Bean
    public ServletRegistrationBean fhirServlet() {
        ServletRegistrationBean servletRegistrationBean = new ServletRegistrationBean();
        FHIRService fhirService = new FHIRService();
        fhirService.setImplementationDescription("FHIR JPA Server");
        servletRegistrationBean.setServlet(fhirService);
        servletRegistrationBean.addInitParameter("FhirVersion", "DSTU2");
        servletRegistrationBean.addUrlMappings("/data/*");
        servletRegistrationBean.setLoadOnStartup(1);
        return servletRegistrationBean;
    }

    @Bean
    public ServletRegistrationBean dispatcherServlet() {
        ServletRegistrationBean servletRegistrationBean = new ServletRegistrationBean();
        DispatcherServlet dispatcherServlet = new DispatcherServlet();
        servletRegistrationBean.setServlet(dispatcherServlet);
        servletRegistrationBean.addInitParameter("dispatchOptionsRequest", "true");
        servletRegistrationBean.addUrlMappings("/data/_services/*");
        servletRegistrationBean.addInitParameter("contextConfigLocation", "classpath:/context/platform-service-config.xml");
        servletRegistrationBean.setLoadOnStartup(2);
        return servletRegistrationBean;
    }

    @Bean
    public FilterRegistrationBean springSecurityFilterChain() {
        FilterRegistrationBean filterRegistrationBean = new FilterRegistrationBean();
        DelegatingFilterProxy delegatingFilterProxy = new DelegatingFilterProxy();
        filterRegistrationBean.setFilter(delegatingFilterProxy);
        filterRegistrationBean.addUrlPatterns("/*");
        return filterRegistrationBean;
    }

    @Bean
    public FilterRegistrationBean csrfFilter() {
        FilterRegistrationBean filterRegistrationBean = new FilterRegistrationBean();
        CsrfHeaderFilter csrfHeaderFilter = new CsrfHeaderFilter();
        filterRegistrationBean.setFilter(csrfHeaderFilter);
        filterRegistrationBean.addUrlPatterns("/*");
        return filterRegistrationBean;
    }

    @Bean
    public FilterRegistrationBean corsFilter() {
        FilterRegistrationBean filterRegistrationBean = new FilterRegistrationBean();
        CORSFilter corsFilter = new CORSFilter();
        filterRegistrationBean.setFilter(corsFilter);
        // A comma separated list of allowed origins. Note: An '*' cannot be used for an allowed origin when using credentials.
        filterRegistrationBean.addInitParameter("cors.allowed.origins", "*");
        // A comma separated list of HTTP verbs, using which a CORS request can be made.
        filterRegistrationBean.addInitParameter("cors.allowed.methods", "GET,POST,PUT,DELETE,OPTIONS");
        // A comma separated list of allowed headers when making a non simple CORS request.
        filterRegistrationBean.addInitParameter("cors.allowed.headers", "X-FHIR-Starter,authorization,Origin,Accept,X-Requested-With,Content-Type,Access-Control-Request-Method,Access-Control-Request-Headers");
        // A comma separated list non-standard response headers that will be exposed to XHR2 object.
        filterRegistrationBean.addInitParameter("cors.exposed.headers", "Location,Content-Location");
        // A flag that suggests if CORS is supported with cookies
        filterRegistrationBean.addInitParameter("cors.support.credentials", "true");
        // A flag to control logging
        filterRegistrationBean.addInitParameter("cors.logging.enabled", "true");
        // Indicates how long (in seconds) the results of a preflight request can be cached in a preflight result cache.
        filterRegistrationBean.addInitParameter("cors.preflight.maxage", "300");
        filterRegistrationBean.addUrlPatterns("/*");
        return filterRegistrationBean;
    }
}
