package com.gmail.peregrin8alde.rest.document.resource;

import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.DELETE;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

import javax.json.Json;
import javax.json.JsonArray;
import javax.json.JsonArrayBuilder;
import javax.json.JsonObject;

import com.gmail.peregrin8alde.rest.document.service.DocumentStorage;

/**
 * Document Resource.
 *
 * @author Michal Gajdos
 */
@Path("document")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class DocumentResource {

    @GET
    public JsonArray getAll() {
        final JsonArrayBuilder arrayBuilder = Json.createArrayBuilder();
        for (final JsonObject document : DocumentStorage.getAll()) {
            arrayBuilder.add(document);
        }
        return arrayBuilder.build();
    }

    @GET
    @Path("{id: \\d+}")
    public JsonObject get(@PathParam("id") final int id) {
        return DocumentStorage.get(id);
    }

    @DELETE
    @Path("{id: \\d+}")
    public JsonObject remove(@PathParam("id") final int id) {
        return DocumentStorage.remove(id);
    }

    @DELETE
    public void removeAll() {
        DocumentStorage.removeAll();
    }

    @POST
    public JsonArray store(final JsonObject document) {
        return Json.createArrayBuilder().add(DocumentStorage.store(document)).build();
    }

    @POST
    @Path("multiple")
    public JsonArray store(final JsonArray documents) {
        final JsonArrayBuilder arrayBuilder = Json.createArrayBuilder();
        for (final JsonObject document : documents.getValuesAs(JsonObject.class)) {
            arrayBuilder.add(DocumentStorage.store(document));
        }
        return arrayBuilder.build();
    }

    @Path("filter")
    public Class<DocumentFilteringResource> getFilteringResource() {
        return DocumentFilteringResource.class;
    }
}
