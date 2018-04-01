package com.xsis.batch137.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.batch137.dao.PurchaseOrderDao;
import com.xsis.batch137.model.PurchaseOrder;

@Service
@Transactional
public class PurchaseOrderService {

	@Autowired
	PurchaseOrderDao poDao;
	
	public List<PurchaseOrder> selectAll(){
		return poDao.selectAll();
	}
}
