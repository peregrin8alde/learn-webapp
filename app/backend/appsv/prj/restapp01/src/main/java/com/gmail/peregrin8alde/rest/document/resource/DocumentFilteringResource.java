package com.gmail.peregrin8alde.rest.document.resource;

import java.util.List;

import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

import javax.json.Json;
import javax.json.JsonArray;
import javax.json.JsonArrayBuilder;
import javax.json.JsonObject;
import javax.json.JsonObjectBuilder;
import javax.json.JsonString;

import com.gmail.peregrin8alde.rest.document.service.DocumentStorage;

/**
 * Resource filtering stored documents based on the presence of given attributes.
 *
 * @author Michal Gajdos
 */
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class DocumentFilteringResource {

    @POST
    public JsonArray filter(final JsonArray properties) {
        final JsonArrayBuilder documents = Json.createArrayBuilder();
        final List<JsonString> propertyList = properties.getValuesAs(JsonString.class);

        for (final JsonObject jsonObject : DocumentStorage.getAll()) {
            final JsonObjectBuilder documentBuilder = Json.createObjectBuilder();

            for (final JsonString property : propertyList) {
                final String key = property.getString();

                if (jsonObject.containsKey(key)) {
                    documentBuilder.add(key, jsonObject.get(key));
                }
            }

            final JsonObject document = documentBuilder.build();
            if (!document.isEmpty()) {
                documents.add(document);
            }
        }

        return documents.build();
    }

}
