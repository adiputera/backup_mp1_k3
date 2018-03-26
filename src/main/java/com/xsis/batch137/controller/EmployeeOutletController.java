package com.xsis.batch137.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xsis.batch137.model.Employee;
import com.xsis.batch137.model.EmployeeOutlet;
import com.xsis.batch137.service.EmployeeOutletService;

@Controller
@RequestMapping("/emp-outlet")
public class EmployeeOutletController {

	@Autowired
	EmployeeOutletService eoService;
	
	@RequestMapping
	@ResponseBody
	public List<EmployeeOutlet> getEmp() {
		return null;
	}
}
