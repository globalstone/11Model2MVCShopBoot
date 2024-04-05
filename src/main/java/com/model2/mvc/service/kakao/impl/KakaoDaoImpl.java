package com.model2.mvc.service.kakao.impl;

import com.model2.mvc.service.domain.Kakao;
import com.model2.mvc.service.kakao.KakaoDao;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.HashMap;

@Repository("kakaoDaoImpl")
public class KakaoDaoImpl implements KakaoDao {

    @Autowired
    @Qualifier("sqlSessionTemplate")
    private SqlSession sqlSession;

    public void setSqlSession(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    public KakaoDaoImpl() {
    }

    @Override
    public void kakaoinsert(Kakao kakao) throws Exception {
        sqlSession.insert("KakaoMapper.kakaoInsert",kakao);
    }

    public Kakao findkakao(HashMap<String, Object> userInfo) throws Exception {
        System.out.println("RN:"+userInfo.get("nickname"));
        System.out.println("RE:"+userInfo.get("email"));
        return sqlSession.selectOne("KakaoMapper.findKakao", userInfo);
    }

    public Kakao kakaoNumber(Kakao userInfo) throws Exception{
        return sqlSession.selectOne("KakaoMapper.kakaoNumber",userInfo);
    }
    public Kakao findByEmail(String email){
        return sqlSession.selectOne("KakaoMapper.findByEmail", email);
    }
}
