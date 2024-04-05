package com.model2.mvc.service.product;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;

import java.util.List;

public interface ProductDao {
	
	public void insertProduct(Product product) throws Exception;
	
	public Product findProduct(int productNo) throws Exception;
	
	public void updateProduct(Product product) throws Exception;
	
	public List<Product> getProductList(Search search) throws Exception;
	
	public int getTotalCount(Search search) throws Exception;

	public List<String> getAllProductNames() throws Exception;

}