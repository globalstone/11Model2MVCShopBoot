package com.model2.mvc.service.domain;

import lombok.Data;

import java.sql.Date;

@Data
public class Purchase {

	private User buyer;
	private String divyAddr;
	private String divyDate;
	private String divyRequest;
	private Date orderDate;
	private String paymentOption;
	private Product purchaseProd;
	private String receiverName;
	private String receiverPhone;
	private String tranCode;
	private int tranNo;

}