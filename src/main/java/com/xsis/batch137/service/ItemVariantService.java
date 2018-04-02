package com.xsis.batch137.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.batch137.dao.ItemInventoryDao;
import com.xsis.batch137.dao.ItemVariantDao;
import com.xsis.batch137.model.Item;
import com.xsis.batch137.model.ItemInventory;
import com.xsis.batch137.model.ItemVariant;
import com.xsis.batch137.model.Outlet;

@Service
@Transactional
public class ItemVariantService {
	
	@Autowired
	ItemVariantDao itemVariantDao;
	
	@Autowired
	ItemInventoryDao itemInventoryDao;
	
	public void save(ItemVariant itemVariant) {
		itemVariantDao.save(itemVariant);
	}
	public ItemVariant getOne(Long id) {
		ItemVariant itemVariant=new ItemVariant();
		itemVariant.setId(id);
		ItemVariant iv = itemVariantDao.getOne(itemVariant);
		return iv;
	}
	
	public List<ItemVariant> selectAll(){
		List<ItemVariant> ivs = itemVariantDao.selectAll();
		return ivs; 
	}
	
	public void delete (ItemVariant itemVariant) {
		itemVariantDao.delete(itemVariant);
	}
	
	public void update(ItemVariant itemVariant) {
		itemVariantDao.update(itemVariant);
	}
	
	
	public void saveAtauUpdate(ItemVariant itemVariant) {
		itemVariantDao.saveAtauUpdate(itemVariant);
	}
	
	public List<ItemVariant> searchVariantByItem(Item item){
		return itemVariantDao.searchVariantByItem(item);
	}
	
}
