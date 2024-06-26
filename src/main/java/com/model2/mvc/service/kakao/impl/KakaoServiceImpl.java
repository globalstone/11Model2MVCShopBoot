package com.model2.mvc.service.kakao.impl;

import com.google.gson.JsonParser;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.model2.mvc.service.domain.Kakao;
import com.model2.mvc.service.kakao.KakaoDao;
import com.model2.mvc.service.kakao.KakaoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

@Service("kakaoServiceImpl")
public class KakaoServiceImpl implements KakaoService {

    @Autowired
    @Qualifier("kakaoDaoImpl")
    private KakaoDao kakaoDao;

    // 카카오 로그인
    @Override
    public String getAccessToken (String authorize_code) {
        String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";

        try {
            URL url = new URL(reqURL);

            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            //    POST 요청을 위해 기본값이 false인 setDoOutput을 true로

            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            //    POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=cec50764919801119a69066d40036533");  //본인이 발급받은 key
            sb.append("&redirect_uri=http://192.168.0.17:8080/kakao/login&response_type=code");     // 본인이 설정해 놓은 경로
            sb.append("&code=" + authorize_code);
            System.out.println("authorize_code : " + authorize_code);
            bw.write(sb.toString());
            bw.flush();

            //    결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            //    요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);

            //    Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

            System.out.println("access_token : " + access_Token);
            System.out.println("refresh_token : " + refresh_Token);

            br.close();
            bw.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return access_Token;
    }

    // 카카오 로그인 정보 저장
    @Override
    public Kakao getUserInfo (String access_Token) throws Exception {

        //    요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
        HashMap<String, Object> userInfo = new HashMap<String, Object>();
        String reqURL = "https://kapi.kakao.com/v2/user/me";
        Kakao insert = new Kakao();
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            //    요청에 필요한 Header에 포함될 내용
            conn.setRequestProperty("Authorization", "Bearer " + access_Token);

            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);

            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
            JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();


            String nickname = properties.getAsJsonObject().get("nickname").getAsString();
            String email = kakao_account.getAsJsonObject().get("email").getAsString();
            String kphone = kakao_account.getAsJsonObject().get("phone_number").getAsString();



            userInfo.put("nickname", nickname);
            userInfo.put("email", email);
            userInfo.put("kphone",kphone);
            insert.setK_name(nickname);
            insert.setK_email(email);
            insert.setK_phone(kphone);


        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

//        Kakao result = kakaoDao.findkakao(userInfo);
//        System.out.println("S:" + result);
//        if (result == null) {
//            kakaoDao.kakaoinsert(insert);
//            return kakaoDao.findkakao(userInfo);
//        } else {
//            return result;
//        }
        Kakao result = kakaoDao.findByEmail(userInfo.get("email").toString());
        System.out.println("S:" + result);
        if (result == null) {
            // 사용자가 데이터베이스에 존재하지 않는 경우, 사용자 정보를 저장합니다.
            kakaoDao.kakaoinsert(insert);
            result = kakaoDao.findByEmail(userInfo.get("email").toString());
        }
        return result;
    }

        @Override
        public Kakao kakaoNumber(Kakao userInfo) throws Exception {
            return kakaoDao.kakaoNumber(userInfo);
        }

}