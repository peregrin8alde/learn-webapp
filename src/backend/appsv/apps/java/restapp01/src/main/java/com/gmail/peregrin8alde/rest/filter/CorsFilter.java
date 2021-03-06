package com.gmail.peregrin8alde.rest.filter;

import java.io.IOException;
import jakarta.ws.rs.container.ContainerRequestContext;
import jakarta.ws.rs.container.ContainerResponseContext;
import jakarta.ws.rs.container.ContainerResponseFilter;
import jakarta.ws.rs.ext.Provider;

@Provider
public class CorsFilter implements ContainerResponseFilter {
 
    @Override
    public void filter(ContainerRequestContext requestContext, ContainerResponseContext responseContext)
        throws IOException {

            // 資格情報を含む場合、 Origin に * は指定できない
            responseContext.getHeaders().add("Access-Control-Allow-Origin", "http://localhost");
            responseContext.getHeaders().add("Access-Control-Allow-Headers", "Content-Type, Authorization");
            responseContext.getHeaders().add("Access-Control-Allow-Methods", "POST, PUT, DELETE");
            // Access-Control-Expose-Headers に指定しないと Fetch API で Location が見れなかった
            responseContext.getHeaders().add("Access-Control-Expose-Headers", "Location");
    }
}