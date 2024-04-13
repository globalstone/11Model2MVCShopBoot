package com.model2.mvc.service.domain;

import lombok.Data;

import java.sql.Date;

@Data
public class Product {

	private String fileName;
	private String manuDate;
	private int price;
	private String prodDetail;
	private String prodName;
	private int prodNo;
	private Date regDate;
	private String proTranCode;
	private int quantity;

}