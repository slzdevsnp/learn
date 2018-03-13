package org.szi.boot.config;//Created on 3/9/18


import org.springframework.boot.autoconfigure.flyway.FlywayDataSource;
import org.springframework.boot.autoconfigure.jdbc.DataSourceBuilder;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

import javax.sql.DataSource;

@Configuration
public class PersistenceConfiguration
{
    @Bean
    @ConfigurationProperties(prefix="spring.datasource")
    @Primary
    public DataSource dataSource() {
        return DataSourceBuilder.create().build();
    }

    @Bean
    @FlywayDataSource
    @ConfigurationProperties(prefix="datasource.flyway") //2nd dataosource to another db to test db migration
    public DataSource flywayDataSource() {
        return DataSourceBuilder.create().build();
    }


}
