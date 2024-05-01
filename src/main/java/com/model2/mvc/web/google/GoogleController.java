package com.model2.mvc.web.google;

import com.model2.mvc.service.google.GoogleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.view.RedirectView;

import java.util.Map;

@Controller
public class GoogleController {

    @Autowired
    @Qualifier("googleServiceImpl")
    private GoogleService googleService;

    @Value("${google.url}")
    private String googleUrl;

    @Value("${google.client.id}")
    private String clientId;

    @Value("${google.callback.url}")
    private String redirectUri;

    @GetMapping("/login/google")
    public RedirectView googleLogin() {
        String url = googleUrl + "?client_id=" + clientId + "&redirect_uri=" + redirectUri + "&response_type=code&scope=email%20profile%20openid&access_type=offline";
        return new RedirectView(url);
    }

    @GetMapping("/api/auth/google/callback")
    public String googleCallback(@RequestParam("code") String code)throws Exception {
        String accessToken = googleService.getAccessToken(code);
        Map<String, Object> userInfo = googleService.getUserInfo(accessToken);

//        User user = userService.saveUser(userInfo);
//
//        // Authenticate the user and create a session
//        session.setAttribute("google", user);
        // ...
        return "redirect:/";
    }
}