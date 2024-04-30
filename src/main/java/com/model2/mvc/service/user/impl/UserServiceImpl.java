package com.model2.mvc.service.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;
import com.model2.mvc.service.user.UserDao;;


//==> 회원관리 서비스 구현
@Service("userServiceImpl")
public class UserServiceImpl implements UserService{

	@Value("${coolsms.apikey}")
	private String apikey;

	@Value("${coolsms.apisecret}")
	private String apisecretkey;

	///Field
	@Autowired
	@Qualifier("userDaoImpl")
	private UserDao userDao;
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	///Constructor
	public UserServiceImpl() {
		System.out.println(this.getClass());
	}

	///Method
	public void addUser(User user) throws Exception {
		userDao.addUser(user);
	}

	public User getUser(String userId) throws Exception {
		return userDao.getUser(userId);
	}

	public Map<String , Object > getUserList(Search search) throws Exception {
		List<User> list= userDao.getUserList(search);
		int totalCount = userDao.getTotalCount(search);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));

		return map;
	}

	public void updateUser(User user) throws Exception {
		userDao.updateUser(user);
	}

	public boolean checkDuplication(String userId) throws Exception {
		boolean result=true;
		User user=userDao.getUser(userId);
		if(user != null) {
			result=false;
		}
		return result;
	}

	//휴대폰번호 인증문자 보내기
	public String PhoneNumberCheck(String to) throws Exception {
		String smsProvider = "https://api.coolsms.co.kr";
		DefaultMessageService messageService = NurigoApp.INSTANCE.initialize(apikey, apisecretkey, smsProvider);

		Random rand = new Random();
		String numStr = "";
		for(int i=0; i<4; i++) {
			String ran = Integer.toString(rand.nextInt(10));
			numStr += ran;
		}

		Message message = new Message();
		message.setFrom("01047528002");    // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
		message.setTo(to);    // 수신전화번호 (ajax로 view 화면에서 받아온 값으로 넘김)
		message.setText("인증번호는 ?? [" + numStr + "] 입니다.");

		SingleMessageSendingRequest request = new SingleMessageSendingRequest(message);
		SingleMessageSentResponse response = messageService.sendOne(request); // 메시지 전송

		return numStr;
	}

}