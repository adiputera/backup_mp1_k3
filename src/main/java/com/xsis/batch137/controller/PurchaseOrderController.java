package com.xsis.batch137.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.xsis.batch137.model.PurchaseOrder;
import com.xsis.batch137.model.Supplier;
import com.xsis.batch137.service.PurchaseOrderService;
import com.xsis.batch137.service.SupplierService;

@Controller
@RequestMapping("/transaksi/purchase-order")
public class PurchaseOrderController {

	@Autowired
	PurchaseOrderService poService;
	
	@Autowired
	SupplierService supService;
	
	@RequestMapping
	public String index(Model model) {
		List<PurchaseOrder> pos = poService.selectAll();
		List<Supplier> sups = supService.selectAll();
		model.addAttribute("pos", pos);
		model.addAttribute("sups", sups);
		return "purchaseOrder/purchaseOrder";
	}
}
