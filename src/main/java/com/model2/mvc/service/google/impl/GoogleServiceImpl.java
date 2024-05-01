package com.model2.mvc.service.google.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.model2.mvc.service.google.GoogleService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

@Service("googleServiceImpl")
public class GoogleServiceImpl implements GoogleService {

    @Value("${google.client.id}")
    private String clientId;

    @Value("${google.client.secret.id}")
    private String clientSecret;

    @Value("${google.callback.url}")
    private String redirectUri;

    @Value("${google.token.url}")
    private String tokenUrl;

    public String getAccessToken(String code) {
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.add("Accept", "application/json");
        headers.add("Content-Type", "application/x-www-form-urlencoded");

        String requestPayload = "code=" + code
                + "&client_id=" + clientId
                + "&client_secret=" + clientSecret
                + "&redirect_uri=" + redirectUri
                + "&grant_type=authorization_code";

        HttpEntity<String> request = new HttpEntity<>(requestPayload, headers);
        ResponseEntity<String> response = restTemplate.exchange(tokenUrl, HttpMethod.POST, request, String.class);

        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, String> responseMap = new HashMap<>();
        try {
            responseMap = objectMapper.readValue(response.getBody(), Map.class);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return responseMap.get("access_token");
    }

    public Map<String, Object> getUserInfo(String accessToken) throws Exception{
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + accessToken);
        HttpEntity<String> entity = new HttpEntity<>("parameters", headers);

        ResponseEntity<String> response = restTemplate.exchange("https://www.googleapis.com/oauth2/v1/userinfo", HttpMethod.GET, entity, String.class);

        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, Object> responseMap = new HashMap<>();
        try {
            responseMap = objectMapper.readValue(response.getBody(), Map.class);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return responseMap;
    }
}