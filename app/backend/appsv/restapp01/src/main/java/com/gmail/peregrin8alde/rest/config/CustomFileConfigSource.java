package com.gmail.peregrin8alde.rest.config;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import org.eclipse.microprofile.config.spi.ConfigSource;

public class CustomFileConfigSource implements ConfigSource {

    private Map<String, String> properties;

    public CustomFileConfigSource(String configFile) {
        // https://docs.oracle.com/javase/tutorial/essential/environment/properties.html
        Properties defaultProps = new Properties();
        try (FileInputStream in = new FileInputStream(configFile)) {
            defaultProps.load(in);
            in.close();

            properties = new HashMap<String, String>();
            for (String key : defaultProps.stringPropertyNames()) {
                properties.put(key, defaultProps.getProperty(key));
            }

            //System.out.println(getName());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public int getOrdinal() {
        return 112;
    }

    @Override
    public Set<String> getPropertyNames() {
        return properties.keySet();
    }

    @Override
    public Map<String, String> getProperties() {

        return properties;
    }

    @Override
    public String getValue(String key) {
        return properties.get(key);
    }

    @Override
    public String getName() {
        return "customFileConfig";
    }

}
