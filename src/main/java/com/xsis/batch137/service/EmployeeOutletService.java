package com.xsis.batch137.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.batch137.dao.EmployeeDao;
import com.xsis.batch137.dao.EmployeeOutletDao;
import com.xsis.batch137.model.Employee;
import com.xsis.batch137.model.EmployeeOutlet;


@Service
@Transactional
public class EmployeeOutletService {

	@Autowired
	EmployeeDao eDao;
	
	@Autowired
	EmployeeOutletDao eoDao;
	
	public List<EmployeeOutlet> getEmp() {
		Employee emp = new Employee();
		emp.setId(1);
		emp.setFirstName("aaaa");
		emp.setLastName("aaaaa");
		emp.setActive(true);
		emp.setHaveAccount(true);
		return eoDao.getEmployeeOutletByEmployee(emp);
	}
}
