package com.gmail.peregrin8alde.rest.resource01.model;

public class ErrorInfo {
    private int statusCode;
    private String messageId;
    private String message;
    private String requestUri;

    public ErrorInfo() {
    }

    public ErrorInfo(int statusCode, String messageId, String message, String requestUri) {
        this.statusCode = statusCode;
        this.messageId = messageId;
        this.message = message;
        this.requestUri = requestUri;
    }

    public int getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(int statusCode) {
        this.statusCode = statusCode;
    }

    public String getMessageId() {
        return messageId;
    }

    public void setMessageId(String messageId) {
        this.messageId = messageId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getRequestUri() {
        return requestUri;
    }

    public void setRequestUri(String requestUri) {
        this.requestUri = requestUri;
    }

}
