package com.xsis.batch137.controller;

import java.io.StringReader;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.omg.CosNaming.NamingContextExtPackage.AddressHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.view.document.AbstractPdfView;

import com.itextpdf.text.FontFactory;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.HeaderFooter;
import com.lowagie.text.Phrase;
import com.lowagie.text.html.simpleparser.HTMLWorker;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.xsis.batch137.model.SalesOrderDetail;
import com.xsis.batch137.model.TransferStock;
import com.xsis.batch137.model.TransferStockDetail;
import com.xsis.batch137.service.TransferStockDetailService;
import com.xsis.batch137.service.TransferStockService;

public class SalesOrderPDFView extends AbstractPdfView {

	@Override
	protected void buildPdfDocument(Map<String, Object> model, Document doc, PdfWriter writer, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		List<SalesOrderDetail> sod = (List<SalesOrderDetail>) model.get("sod");
		String customer = null;
		Date date = null;
		float total = 0;
		
		for (SalesOrderDetail sodDet : sod) {
			customer=sodDet.getSalesOrder().getCustomer().getName();
			date = sodDet.getCreatedOn();
			total = sodDet.getSalesOrder().getGrandTotal();
		}
		
		//System.out.println(ts.getId());
		//TransferStock ts = tsService.getTransferStockById(id);
		
		PdfPTable table = new PdfPTable(4);
		table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
		table.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
		
		HTMLWorker htmlWorker = new HTMLWorker(doc);
		
		 String str = "<html><head></head><body>"+
				 	        "<h1 style='text-align: center;'>Sales Order</h1>" +
				 	        "<br/>" +
				 	        "<p style='text-align: left ;'>Customer : "+customer+"</p>"+
				 	        "<p style=''text-align: right ;'>Date : "+date+"</p>"+
				 	        "</body></html>";
				 	      htmlWorker.parse(new StringReader(str));
			
			 table.addCell("Item Name");
			 table.addCell("Price");
			 table.addCell("Quantity");
			 table.addCell("Total");

			for (SalesOrderDetail salesOrderDetail : sod) {
				table.addCell(salesOrderDetail.getItemVariant().getItem().getName() +" - "+salesOrderDetail.getItemVariant().getName());
				table.addCell(String.valueOf(salesOrderDetail.getUnitPrice())); 
				table.addCell(String.valueOf(salesOrderDetail.getQty())); 
				table.addCell(String.valueOf(salesOrderDetail.getSubTotal())); 
			}
			
			table.addCell("Total Pembayaran");
			table.addCell("");
			table.addCell("");
			table.addCell(String.valueOf(total));
			doc.add(table);
	}
}