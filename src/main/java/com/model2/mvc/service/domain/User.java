package com.model2.mvc.service.domain;

import lombok.Data;

import java.sql.Date;


//==>회원정보를 모델링(추상화/캡슐화)한 Bean
@Data
public class User {

	///Field
	private String userId;
	private String userName;
	private String password;
	private String role;
	private String ssn;
	private String phone;
	private String addr;
	private String email;
	private Date regDate;
	/////////////// EL 적용 위해 추가된 Field ///////////
	private String phone1;
	private String phone2;
	private String phone3;
	//////////////////////////////////////////////////////////////////////////////////////////////
	// JSON ==> Domain Object  Binding을 위해 추가된 부분
	private String regDateString;

}