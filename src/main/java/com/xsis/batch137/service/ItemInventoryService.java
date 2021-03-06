package com.xsis.batch137.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.batch137.dao.ItemInventoryDao;
import com.xsis.batch137.model.Item;
import com.xsis.batch137.model.ItemInventory;
import com.xsis.batch137.model.ItemVariant;
import com.xsis.batch137.model.Outlet;

@Service
@Transactional
public class ItemInventoryService {
	@Autowired
	ItemInventoryDao itemInventoryDao;
	
	@Autowired
	HttpSession httpSession;
	
	public void save(ItemInventory itemInventory) {
		itemInventoryDao.save(itemInventory);
	}
	public ItemInventory getOne(Long id) {
		ItemInventory itemInventory=new ItemInventory();
		itemInventory.setId(id);
		return itemInventoryDao.getOne(itemInventory);
	}
	public List<ItemInventory> selectAll(){
		return itemInventoryDao.selectAll();
	}
	
	public void delete (ItemInventory itemInventory) {
		itemInventoryDao.delete(itemInventory);
	}
	
	public void update(ItemInventory itemInventory) {
		itemInventoryDao.update(itemInventory);
	}
	
	public void updateTransferStock(ItemInventory itemInventory) {
		itemInventoryDao.updateTransferStock(itemInventory);
	}
	
	public List<ItemInventory> searchInventoryByVariant(Long search){
		return itemInventoryDao.searchInventoryByVariant(search);
	};

	
	public void saveAtauUpdate(ItemInventory itemInventory) {
		itemInventoryDao.saveAtauUpdate(itemInventory);
	}
	
	public List<ItemInventory> searchInventoryByItem(Item item){
		return itemInventoryDao.searchInventoryByItem(item);
	}

	public List<ItemInventory> searchItemInventoryByItemName(String search) {
		return itemInventoryDao.searchItemInventoryByItemName(search);
	}
	public List<ItemInventory> getItemInventoryByOutlet(Long search, Long id) {
		// TODO Auto-generated method stub
		return itemInventoryDao.getItemInvetoryByOutlet(search,id);
	}
	public List<ItemInventory> listInventoryByOutlet(Long search) {
		// TODO Auto-generated method stub
		return itemInventoryDao.listInventoryByOutlet(search);
	}
	public void updateSalesOrder(ItemInventory itemInventory) {
		// TODO Auto-generated method stub
		itemInventoryDao.updateSalesOrder(itemInventory);
	}
	public List<ItemInventory> getItemInventoryByOutletLogin(long outId) {
		// TODO Auto-generated method stub
		return itemInventoryDao.getItemInventoryByOutletLogin(outId);
	}
	
	public List<ItemInventory> searchItemInventoryByItemNameAndOutlet(String search){
		Outlet outlet = (Outlet) httpSession.getAttribute("outletLogin");
		return itemInventoryDao.searchItemInventoryByItemNameAndOutlet(search, outlet);
	}
}
