package com.model2.mvc.web.product;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.Map;


@Controller
@RequestMapping("/product/*")
public class ProductController {

	//Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	public ProductController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@Value("#{commonProperties['uploadTempDir']}")
	String uploadTempDir;
	
//	@RequestMapping("/addProduct.do")
//	public String addProduct(@ModelAttribute("ProdVO") Product product) throws Exception{
//
//		System.out.println("/addProduct.do");
//
//		String md = product.getManuDate();
//		String[] manu = md.split("-");
//		String manudate = manu[0]+manu[1]+manu[2];
//		product.setManuDate(manudate);
//
//		productService.addProduct(product);
//
//
//		return "forward:/product/readProductView.jsp";
//	}

	@GetMapping(value = "addProduct")
	public String addProduct() throws Exception{
		System.out.println("productService.GET");
		return "forward:/product/readProductView.jsp";
	}

	@PostMapping(value = "addProduct")
	public String addProduct(@ModelAttribute("ProdVO") Product product,
							 @RequestParam("uploadFile") MultipartFile file)throws Exception {
		System.out.println("addProduct.Post");

		if(file != null & file.getSize() >0) {

			file.transferTo(new File(uploadTempDir, file.getOriginalFilename()));
			product.setFileName(file.getOriginalFilename());
		}

		String md = product.getManuDate();
		String[] manu = md.split("-");
		String manudate = manu[0] + manu[1] + manu[2];
		product.setManuDate(manudate);

		productService.addProduct(product);
		return "forward:/product/readProductView.jsp";
	}

	//	@RequestMapping("/getProduct.do")
	@GetMapping(value = "getProduct/{prodNo}/{menu}")
	public String getProduct(@PathVariable int prodNo,
							 @PathVariable String menu,
							 @CookieValue(value = "history",defaultValue = "") String history,
							 HttpServletResponse response,
							 Model model) throws Exception {
		System.out.println("/getProduct.do");

		Product prod = productService.getProduct(prodNo);
		model.addAttribute("prod", prod);
		model.addAttribute("menu", menu);

		String cookiehistory = String.valueOf(prodNo);
		if (!history.isEmpty()) {
			history += "/" + cookiehistory;
		} else {
			history = cookiehistory;
		}
		Cookie cookie = new Cookie("history", history);
		cookie.setPath("/"); // 쿠키의 유효 경로를 전체로 설정
		response.addCookie(cookie);

		return "forward:/product/updateProductView.jsp";
	}
	
//	@RequestMapping("/updateProduct.do")
	@PostMapping(value = "updateProduct")
	public String updateProduct(@ModelAttribute("update") Product prod,
								@RequestParam("uploadFile") MultipartFile file) throws Exception{

		if( file != null & file.getSize() >0) {
			file.transferTo(new File(uploadTempDir, file.getOriginalFilename()));
			prod.setFileName(file.getOriginalFilename());
		}

		System.out.println("/updateProduct.do");
		productService.updateProduct(prod);
		
		return "forward:/product/updateReadProduct.jsp";
	}
	
//	@RequestMapping("/updateProductView.do")
	@GetMapping(value = "updateProduct/{prodNo}/{menu}")
	public String updateProduct(@PathVariable int prodNo,
								@PathVariable String menu,
//								@RequestParam int prodNo,
								Model model) throws Exception{
		
		System.out.println("/updateProductView.do");
		Product prod = productService.getProduct(prodNo);
		model.addAttribute("UpdateProdVO", prod);
		
		return "forward:/product/updateProduct.jsp";
	}
	
	@RequestMapping(value = "listProduct/{menu}")
	public String listProduct(@ModelAttribute("Search") Search search,
//							  @RequestParam("menu") String menu,
							  @PathVariable String menu,
							  Model model) throws Exception{
		
		System.out.println("/listProduct.POST / GET");

		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		
		Map<String, Object> map = productService.getProductList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue() , pageUnit, pageSize);
		System.out.println(resultPage);
		
		
		model.addAttribute("menu",menu);
		model.addAttribute("list",map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		
		
		return "forward:/product/productList.jsp";
	}
}
