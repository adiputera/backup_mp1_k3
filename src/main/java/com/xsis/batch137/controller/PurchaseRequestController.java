package com.xsis.batch137.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.xsis.batch137.model.Item;
import com.xsis.batch137.model.ItemInventory;
import com.xsis.batch137.model.Outlet;
import com.xsis.batch137.model.PurchaseRequest;
import com.xsis.batch137.model.PurchaseRequestDetail;
import com.xsis.batch137.service.ItemInventoryService;
import com.xsis.batch137.service.OutletService;
import com.xsis.batch137.service.PurchaseRequestService;

@Controller
@RequestMapping("/transaksi/purchase-request")
public class PurchaseRequestController {

	@Autowired
	PurchaseRequestService prService;
	
	@Autowired
	OutletService oService;
	
	@Autowired
	ItemInventoryService iService;
	
	@Autowired
	HttpSession httpSession;
	
	@RequestMapping
	public String index(Model model) {
		List<PurchaseRequest> prs = prService.selectByOutlet();
		List<ItemInventory> items = iService.selectAll();
		model.addAttribute("prs", prs);
		model.addAttribute("items", items);
		return "purchaseRequest/purchaseRequest";
	}
	
	@RequestMapping("/detail/{id}")
	public String detail(@PathVariable long id, Model model) {
		PurchaseRequest pr = prService.getOne(id);
		model.addAttribute("pr", pr);
		return "purchaseRequest/purchaseRequestDetail";
	}
	
	@RequestMapping(value="/save", method = RequestMethod.POST)
	@ResponseStatus(HttpStatus.OK)
	public void save(@RequestBody PurchaseRequest pr) {
		prService.save(pr);
	}
	
	@RequestMapping("/get-all")
	@ResponseBody
	public List<PurchaseRequest> getAll(){
		return prService.selectAll();
	}
	
	@RequestMapping(value="/search-item",method=RequestMethod.GET)
	@ResponseBody
	public List<ItemInventory> searchItem(@RequestParam(value="search", defaultValue="") String search){
		List<ItemInventory > itemInventories = iService.searchItemInventoryByItemNameAndOutlet(search);
		return itemInventories;
	}
	
	@RequestMapping(value="/get-item",method=RequestMethod.GET)
	@ResponseBody
	public List<ItemInventory> getItem(){
		Outlet outlet = (Outlet) httpSession.getAttribute("outletLogin");
		List<ItemInventory > itemInventories = iService.getItemInventoryByOutletLogin(outlet.getId());
		return itemInventories;
	}
	
	@RequestMapping("/search-status")
	@ResponseBody
	public List<PurchaseRequest> getByStatus(@RequestParam(value="search", defaultValue="") String status){
		return prService.getPRByStatus(status);
	}
	
	@RequestMapping("/search")
	@ResponseBody
	public List<PurchaseRequest> search(@RequestParam(value="search", defaultValue="") String search){
		return prService.searchGlobal(search);
	}
	
	@RequestMapping("/search-date")
	@ResponseBody
	public List<PurchaseRequest> getByDate(@RequestParam(value="awal", defaultValue="") @DateTimeFormat(pattern="yyyy-MM-dd") Date awal, @RequestParam(value="akhir", defaultValue="") @DateTimeFormat(pattern="yyyy-MM-dd") Date akhir){
		return prService.getPRByDate(awal, akhir);
	}
	
	@RequestMapping("/search-one-date")
	@ResponseBody
	public List<PurchaseRequest> getByOneDate(@RequestParam(value="date", defaultValue="") @DateTimeFormat(pattern="yyyy-MM-dd") Date date){
		return prService.getPRByOneDate(date);
	}
	
	@RequestMapping("/get-one/{id}")
	@ResponseBody
	public PurchaseRequest getOne(@PathVariable long id) {
		return prService.getOne(id);
	}
	
	@RequestMapping(value="/approve/{id}", method=RequestMethod.GET)
	@ResponseStatus(HttpStatus.OK)
	public void approve(@PathVariable long id) {
		prService.approve(id);
	}
	
	@RequestMapping(value="/reject/{id}", method= RequestMethod.GET)
	@ResponseStatus(HttpStatus.OK)
	public void reject(@PathVariable long id) {
		prService.reject(id);
	}
	
	@RequestMapping(value="/create-po/{id}", method=RequestMethod.GET)
	@ResponseStatus(HttpStatus.OK)
	public void createPo(@PathVariable long id) {
		prService.createPo(id);
	}
	
	@RequestMapping("/get-inventory")
	@ResponseBody
	public List<Object> getInventory(@RequestParam(value="idPr", defaultValue="") long idPr, @RequestParam(value="idPrd", defaultValue="") long idPrd){
		return prService.getInventoryByVariantDanOutlet(idPrd, idPr);
	}
}
