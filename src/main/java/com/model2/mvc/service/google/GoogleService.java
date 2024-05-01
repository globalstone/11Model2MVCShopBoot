package com.model2.mvc.service.google;

import java.util.Map;

public interface GoogleService {

    public String getAccessToken(String code) throws Exception;

    public Map<String, Object> getUserInfo(String accessToken) throws Exception;
}
