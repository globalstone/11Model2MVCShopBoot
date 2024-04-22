package com.model2.mvc.web.user;

import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 Controller
@Controller
@RequestMapping("/user/*")
public class UserController {

	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method 구현 않음

	@Autowired
	JavaMailSenderImpl mailSender;

	public UserController(){
		System.out.println(this.getClass());
	}

	@Value("${pageUnit}")
	int pageUnit;
	@Value("${pageSize}")
	int pageSize;


	@RequestMapping( value="addUser", method=RequestMethod.GET )
	public String addUser() throws Exception{

		System.out.println("/user/addUser : GET");

		return "redirect:/user/addUserView.jsp";
	}

	@RequestMapping( value="addUser", method=RequestMethod.POST )
	public String addUser( @ModelAttribute("user") User user ) throws Exception {

		System.out.println("/user/addUser : POST");
		//Business Logic
		userService.addUser(user);

		return "redirect:/user/loginView.jsp";
	}


	@RequestMapping( value="getUser", method=RequestMethod.GET )
	public String getUser( @RequestParam("userId") String userId , Model model ) throws Exception {

		System.out.println("/user/getUser : GET");
		//Business Logic
		User user = userService.getUser(userId);
		// Model 과 View 연결
		model.addAttribute("user", user);

		return "forward:/user/getUser.jsp";
	}


	@RequestMapping( value="updateUser", method=RequestMethod.GET )
	public String updateUser( @RequestParam("userId") String userId , Model model ) throws Exception{

		System.out.println("/user/updateUser : GET");
		//Business Logic
		User user = userService.getUser(userId);
		// Model 과 View 연결
		model.addAttribute("user", user);

		return "forward:/user/updateUser.jsp";
	}

	@RequestMapping( value="updateUser", method=RequestMethod.POST )
	public String updateUser( @ModelAttribute("user") User user , Model model , HttpSession session) throws Exception{

		System.out.println("/user/updateUser : POST");
		//Business Logic
		userService.updateUser(user);

		String sessionId=((User)session.getAttribute("user")).getUserId();
		if(sessionId.equals(user.getUserId())){
			session.setAttribute("user", user);
		}

		return "redirect:/user/getUser?userId="+user.getUserId();
	}


	@RequestMapping( value="login", method=RequestMethod.GET )
	public String login() throws Exception{

		System.out.println("/user/logon : GET");

		return "redirect:/user/loginView.jsp";
	}

	@RequestMapping( value="login", method=RequestMethod.POST )
	public String login(@ModelAttribute("user") User user , HttpSession session ) throws Exception{

		System.out.println("/user/login : POST");
		//Business Logic
		User dbUser=userService.getUser(user.getUserId());

		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}

		return "redirect:/index.jsp";
	}


	@RequestMapping( value="logout", method=RequestMethod.GET )
	public String logout(HttpSession session ) throws Exception{

		System.out.println("/user/logout : POST");

		session.invalidate();

		return "redirect:/index.jsp";
	}


	@RequestMapping( value="checkDuplication", method=RequestMethod.POST )
	public String checkDuplication( @RequestParam("userId") String userId , Model model ) throws Exception{

		System.out.println("/user/checkDuplication : POST");
		//Business Logic
		boolean result=userService.checkDuplication(userId);
		// Model 과 View 연결
		model.addAttribute("result", new Boolean(result));
		model.addAttribute("userId", userId);

		return "forward:/user/checkDuplication.jsp";
	}


	@RequestMapping( value="listUser" )
	public String listUser( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{

		System.out.println("/user/listUser : GET / POST");

		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		// Business logic 수행
		Map<String , Object> map=userService.getUserList(search);

		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);

		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);

		return "forward:/user/listUser.jsp";
	}

	//이메일 인증
	@PostMapping("/EmailAuth")
	@ResponseBody
	public int emailAuth(String email) {


		//난수의 범위 111111 ~ 999999 (6자리 난수)
		Random random = new Random();
		int checkNum = random.nextInt(888888)+111111;

		//이메일 보낼 양식
		String setFrom = "botom12@naver.com"; //2단계 인증 x, 메일 설정에서 POP/IMAP 사용 설정에서 POP/SMTP 사용함으로 설정o
		String toMail = email;
		String title = "회원가입 인증 이메일";
		String content = "인증 코드는 : " + checkNum + "이거야" +
				"<br>" +
				"해당 코드 입력해 ";

		try {
			MimeMessage message = mailSender.createMimeMessage(); //Spring에서 제공하는 mail API
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			helper.setFrom(setFrom,"재민이네상점");
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);
		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println("숫자 확인용 : " +checkNum);
		return checkNum;
	}

	//문자 인증
	@PostMapping("/memberPhoneCheck")
	public @ResponseBody String memberPhoneCheck(@RequestParam(value="to") String to) throws Exception {

		return userService.PhoneNumberCheck(to);
	}
}