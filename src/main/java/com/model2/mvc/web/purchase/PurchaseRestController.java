package com.model2.mvc.web.purchase;

import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {

	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	public PurchaseRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@RequestMapping(value = "json/getPurchase",method = RequestMethod.GET)
	public ModelAndView getPurchase(@RequestParam int tranNo, Model model) throws Exception{

		System.out.println("getPurchase.GET CALL");

		Purchase purchase = purchaseService.getPurchase(tranNo);
		model.addAttribute("purVo", purchase);

		String viewName = "forward:/purchase/purchaseReadView.jsp";

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);

		return modelAndView;
	}
}
